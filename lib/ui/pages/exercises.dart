import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/model/exercises.dart';
import 'package:gymandfood/widgets/exercise_tile.dart';
import 'package:gymandfood/services/database.dart';

class Exercises extends StatefulWidget {
  final String exerciseMuscleId;

  const Exercises({Key key, this.exerciseMuscleId}) : super(key: key);
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  DatabaseService databaseService = DatabaseService();
  List<Exercise> filteredExercises = [];
  String userId;
  String userTypeSend;
  @override
  void initState() {
    HelperFunctions.getUserLoggedInID().then((value) {
      setState(() {
        userId = value;
      });
    });
    super.initState();
  }

  Future<String> getUserType() async {
    String userType;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .get()
        .then((value) {
      userType = value.data()['userType'];
      userTypeSend = value.data()['userType'];
    });
    return Future.value(userType.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 28,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: databaseService.getExercises(widget.exerciseMuscleId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 0),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot els = snapshot.data.docs[index];
                      return GestureDetector(
                        onLongPress: () {
                          if (userTypeSend == "admin") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ExerciseEdit(exerciseDocId: els.id)));
                          }
                        },
                        child: ExerciseTile(
                          exerciseId: els["exercise_id"],
                          exercisePic: els["exercise_pic"],
                          exerciseName: els["exercise_name"],
                          exerciseDesc: els["exercise_desc"],
                          exerciseMuscleId: els["exercise_muscle_id"],
                          exerciseMuscle: els["exercise_muscle"],
                        ),
                      );
                    }),
              );
            }
          }),
      floatingActionButton: FutureBuilder(
          future: getUserType(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data == "admin"
                ? FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                    backgroundColor: Colors.green,
                  )
                : Text("");
          }),
    );
  }
}

class ExerciseEdit extends StatefulWidget {
  String exerciseDocId;

  ExerciseEdit({this.exerciseDocId});
  @override
  _ExerciseEditState createState() => _ExerciseEditState();
}

class _ExerciseEditState extends State<ExerciseEdit> {
  static GlobalKey<FormState> _formKeyy=GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String textCatName, textCatDesc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKeyy,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: StreamBuilder(
                  stream: databaseService.getExerciseInfo(widget.exerciseDocId),
                  builder: (context, snapshotExerciseInfo) {
                    if (snapshotExerciseInfo.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          Image.network(
                            snapshotExerciseInfo.data["exercise_pic"],
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Exercise Name",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextFormField(
                                initialValue: snapshotExerciseInfo
                                    .data["exercise_name"]
                                    .toString(),
                                onChanged: (value) {
                                  textCatName = value;
                                },
                                validator: (value) {
                                  return value.isEmpty
                                      ? "Enter category name"
                                      : null;
                                },
                                maxLength: 50,
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Text("Exercise Desc",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextFormField(
                                initialValue: snapshotExerciseInfo
                                    .data["exercise_desc"]
                                    .toString(),
                                onChanged: (value) {
                                  textCatDesc = value;
                                },
                                validator: (value) {
                                  return value.isEmpty
                                      ? "Enter category description"
                                      : null;
                                },
                                minLines: null,
                                maxLines: null,
                                maxLength: 1000,
                                expands: false,
                                textAlign: TextAlign.left,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 120,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "CANCEL",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 120,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Text(
                                    "UPDATE",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
