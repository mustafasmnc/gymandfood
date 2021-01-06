import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/model/user_exercises.dart';
import 'package:gymandfood/services/database.dart';
import 'package:readmore/readmore.dart';

class ExerciseTile extends StatefulWidget {
  final String exerciseId;
  final String exercisePic;
  final String exerciseName;
  final String exerciseDesc;
  final String exerciseMuscleId;
  final String exerciseMuscle;

  const ExerciseTile(
      {Key key,
      this.exerciseId,
      this.exercisePic,
      this.exerciseName,
      this.exerciseDesc,
      this.exerciseMuscleId,
      this.exerciseMuscle})
      : super(key: key);

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  DatabaseService databaseService = DatabaseService();
  TextEditingController exerciseSet = TextEditingController();
  TextEditingController exerciseRepeat = TextEditingController();
  String userId;

  @override
  void initState() {
    HelperFunctions.getUserLoggedInID().then((value) {
      setState(() {
        userId = value;
      });
    });

    super.initState();
  }

  addExercise(
      String userId,
      String exerciseId,
      String exerciseName,
      String exerciseSet,
      String exerciseRepeat,
      String exerciseMuscle,
      String exerciseMuscleId,
      String exercisePic,
      String dayNumber) async {
    if (exerciseRepeat == "" || exerciseSet == "") {
      print("repeat and set cannot be null");

      showExerciseUpdateScreen(
          context, "Error", "Repeat and set cannot be null.");
    } else {
      String dataId = dayNumber + "|" + exerciseId;
      Map<String, String> exerciseData = {
        "exerciseId": exerciseId,
        "exerciseName": exerciseName,
        "exerciseSet": exerciseSet,
        "exerciseRepeat": exerciseRepeat,
        "exerciseMuscle": exerciseMuscle,
        "exerciseMuscleId": exerciseMuscleId,
        "exercisePic": exercisePic,
        "dayNumber": dayNumber,
      };
      databaseService.addExercise(userId, exerciseData, dataId).then((value) {
        if (value == "added") {
          showExerciseUpdateScreen(context, "Added", "Exercise Added.");
        }
        if (value == "updated") {
          showExerciseUpdateScreen(context, "Updated", "Exercise Updated.");
        }
      });
    }
  }

  showExerciseUpdateScreen(BuildContext context, String title, String content) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'helvetica_neue_light',
                              fontSize: 20,
                              color:
                                  title == "Error" ? Colors.red : Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Divider(color: Colors.black54),
                          SizedBox(height: 10),
                          Text(
                            content,
                            style: TextStyle(
                              fontFamily: 'helvetica_neue_light',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      )),
                  InkWell(
                    child: GestureDetector(
                      onTap: () {
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
                          "Okay",
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

  showAlertDialog(BuildContext context, String title, String content) {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 150,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // dialog top
            new Row(
              children: <Widget>[
                new Container(
                  // padding: new EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  ),
                  child: new Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            // dialog centre
            new Container(
                child: Text(content,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: 'helvetica_neue_light',
                    ))),

            // dialog bottom
            new Container(
              padding: new EdgeInsets.all(16.0),
              decoration: new BoxDecoration(
                  color: const Color(0xFF33b17c),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: new Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      child: dialog,
      // builder: (BuildContext context) {
      //   return alert;
      // },
    );
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0),
            )
          ]),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.exercisePic,
                fit: BoxFit.contain,
              ),
            ),
            //SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.exerciseName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        useRootNavigator: true,
                        context: context,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (context) {
                          return SingleChildScrollView(
                            child: StatefulBuilder(
                              builder: (context, setModalState) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    padding: const EdgeInsets.only(
                                        top: 32,
                                        bottom: 32,
                                        left: 10,
                                        right: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Set:",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: TextField(
                                                controller: exerciseSet,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Repeat:",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: TextField(
                                                controller: exerciseRepeat,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                addExercise(
                                                    userId,
                                                    widget.exerciseId,
                                                    widget.exerciseName,
                                                    exerciseSet.text,
                                                    exerciseRepeat.text,
                                                    widget.exerciseMuscle,
                                                    widget.exerciseMuscleId,
                                                    widget.exercisePic,
                                                    "1");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Text("Mon",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                addExercise(
                                                    userId,
                                                    widget.exerciseId,
                                                    widget.exerciseName,
                                                    exerciseSet.text,
                                                    exerciseRepeat.text,
                                                    widget.exerciseMuscle,
                                                    widget.exerciseMuscleId,
                                                    widget.exercisePic,
                                                    "2");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Text("Tue",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                addExercise(
                                                    userId,
                                                    widget.exerciseId,
                                                    widget.exerciseName,
                                                    exerciseSet.text,
                                                    exerciseRepeat.text,
                                                    widget.exerciseMuscle,
                                                    widget.exerciseMuscleId,
                                                    widget.exercisePic,
                                                    "3");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Text("Wed",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                addExercise(
                                                    userId,
                                                    widget.exerciseId,
                                                    widget.exerciseName,
                                                    exerciseSet.text,
                                                    exerciseRepeat.text,
                                                    widget.exerciseMuscle,
                                                    widget.exerciseMuscleId,
                                                    widget.exercisePic,
                                                    "4");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Text("Thu",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                addExercise(
                                                    userId,
                                                    widget.exerciseId,
                                                    widget.exerciseName,
                                                    exerciseSet.text,
                                                    exerciseRepeat.text,
                                                    widget.exerciseMuscle,
                                                    widget.exerciseMuscleId,
                                                    widget.exercisePic,
                                                    "5");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Text("Fri",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                addExercise(
                                                    userId,
                                                    widget.exerciseId,
                                                    widget.exerciseName,
                                                    exerciseSet.text,
                                                    exerciseRepeat.text,
                                                    widget.exerciseMuscle,
                                                    widget.exerciseMuscleId,
                                                    widget.exercisePic,
                                                    "6");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Text("Sat",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                addExercise(
                                                    userId,
                                                    widget.exerciseId,
                                                    widget.exerciseName,
                                                    exerciseSet.text,
                                                    exerciseRepeat.text,
                                                    widget.exerciseMuscle,
                                                    widget.exerciseMuscleId,
                                                    widget.exercisePic,
                                                    "7");
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Text("Sun",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    })
              ],
            ),
            ReadMoreText(
              widget.exerciseDesc,
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read',
              trimExpandedText: 'Less',
              colorClickableText: Colors.red,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dayButton(String dayName, String exerciseSet, String exerciseRepeat) {
    UserExercises userExercises = UserExercises();
    return GestureDetector(
        onTap: () {
          print("Day: $dayName, Set: $exerciseSet, Repeat: $exerciseRepeat");
          userExercises.exerciseId = widget.exerciseId;
          userExercises.exerciseName = widget.exerciseName;
          userExercises.exerciseSet = exerciseSet;
          userExercises.exerciseRepeat = exerciseRepeat;
          userExercises.exercisePic = widget.exerciseMuscleId == "1"
              ? "assets/chest.jpg"
              : widget.exerciseMuscleId == "2"
                  ? "assets/back1.jpg"
                  : widget.exerciseMuscleId == "3"
                      ? "assets/shoulder.jpg"
                      : widget.exerciseMuscleId == "4"
                          ? "assets/biceps.jpg"
                          : widget.exerciseMuscleId == "5"
                              ? "assets/triceps.jpg"
                              : widget.exerciseMuscleId == "6"
                                  ? "assets/leg1.jpg"
                                  : widget.exerciseMuscleId == "7"
                                      ? "assets/abdominal.jpg"
                                      : "assets/rest.png";
          userExercises.exerciseMuscle = widget.exerciseMuscle;
          userExercises.exerciseMuscleId = widget.exerciseMuscleId;
          userExercises.exerciseDayofweek = dayName == "Mon"
              ? "1"
              : dayName == "Tue"
                  ? "2"
                  : dayName == "Wed"
                      ? "3"
                      : dayName == "Thu"
                          ? "4"
                          : dayName == "Fri"
                              ? "5"
                              : dayName == "Sat"
                                  ? "6"
                                  : "7";
          user_exercises.add(userExercises);
          //print(userExercises.exercisePic);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          padding: EdgeInsets.all(10),
          child: Text(dayName,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
              )),
        ));
  }
}
