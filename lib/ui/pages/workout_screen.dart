import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/widgets/full_pic_screen.dart';
import 'package:intl/intl.dart';

class WorkoutScreen extends StatefulWidget {
  Color color;
  String userId;
  String dayId;
  WorkoutScreen(this.color, this.userId, this.dayId);
  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  DatabaseService databaseService = DatabaseService();
  TextEditingController textExerciseSet = TextEditingController();
  TextEditingController textExerciseRepeat = TextEditingController();

  showExerciseUpdateScreen(String exerciseId, String exercisePic,
      String exerciseName, String exerciseSet, String exerciseRepeat) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 370.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image(
                          image: NetworkImage(
                            exercisePic,
                          ),
                          height: 120,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        exerciseName,
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  new Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 75,
                                child: Text(
                                  "Set",
                                  style: TextStyle(
                                    fontFamily: 'helvetica_neue_light',
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  decoration: new InputDecoration(
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.teal)),
                                    hintText: exerciseSet,
                                  ),
                                  controller: textExerciseSet,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  width: 75,
                                  child: Text(
                                    "Repeat",
                                    style: TextStyle(
                                      fontFamily: 'helvetica_neue_light',
                                      fontSize: 20,
                                    ),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: TextField(
                                  decoration: new InputDecoration(
                                    border: new UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.teal)),
                                    hintText: exerciseRepeat,
                                  ),
                                  controller: textExerciseRepeat,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      )),
                  InkWell(
                    child: GestureDetector(
                      onTap: () {
                        String exset, exrepeat;
                        if (textExerciseSet.text == "") {
                          exset = exerciseSet;
                        } else {
                          exset = textExerciseSet.text;
                        }
                        if (textExerciseRepeat.text == "") {
                          exrepeat = exerciseSet;
                        } else {
                          exrepeat = textExerciseRepeat.text;
                        }

                        databaseService.updateUserExercises(
                            widget.userId, exerciseId, exset, exrepeat);

                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xff00bfa5),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEEE, d MMM y').format(now);
    return Scaffold(
      backgroundColor: widget.color.withOpacity(.7),
      appBar: AppBar(
        backgroundColor: widget.color.withOpacity(.0),
        toolbarHeight: 70,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Workouts",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 1)
            ],
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 16),
        child: Column(
          children: [
            SizedBox(height: 5),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: databaseService.getUserExercises(
                      widget.userId, widget.dayId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data.docs.length == 0) {
                      return Center(
                          child: Text(
                        "Sorry, no exercise found.\nPlease add exercise.",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ));
                    } else {
                      try {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot aue =
                                    snapshot.data.docs[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Card(
                                    color: widget.color.withOpacity(.2),
                                    child: GestureDetector(
                                      onTap: () {
                                        showExerciseUpdateScreen(
                                            aue.id,
                                            aue["exercisePic"],
                                            aue["exerciseName"],
                                            aue["exerciseSet"],
                                            aue["exerciseRepeat"]);
                                      },
                                      onLongPress: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return FullPicScreen(
                                              exercisePic: aue["exercisePic"]);
                                        }));
                                      },
                                      child: ListTile(
                                        trailing: GestureDetector(
                                            onTap: () {
                                              databaseService
                                                  .removeUserExercise(
                                                      widget.userId, aue.id);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            )),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            aue["exercisePic"],
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: Text(
                                          aue["exerciseName"],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              "Set: ${aue["exerciseSet"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Repeat: ${aue["exerciseRepeat"]}",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      } catch (e) {
                        print(e);
                        return Center(
                          child: Text("Error"),
                        );
                      }
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
