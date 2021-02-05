import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/model/exercises.dart';
import 'package:gymandfood/widgets/exercise_tile.dart';
import 'package:gymandfood/services/database.dart';
import 'package:image_picker/image_picker.dart';

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
                          exerciseId: els.id,
                          exercisePic: els["exercise_pic"],
                          exerciseName: els["exercise_name"],
                          exerciseDesc: els["exercise_desc"],
                          exerciseMuscleId: els["exercise_muscle_id"],
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
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String textExerciseName, textExerciseDesc;
  File imgFile;

  final imgPicker = ImagePicker();

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    final picker = ImagePicker();
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 20);

    setState(() {
      imgFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  void openGallery() async {
    final picker = ImagePicker();
    PickedFile pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      imgFile = File(pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  updateExercise(String exerciseExistingPic, String exerciseName,
      String exerciseDesc) async {
    if (imgFile != null) {
      FirebaseStorage storage = FirebaseStorage.instance;

      String downloadUrl;
      var pieces = imgFile.path.split('/');
      Reference ref =
          storage.ref().child('uploads/${pieces[pieces.length - 1]}');
      UploadTask uploadTask = ref.putFile(imgFile);
      uploadTask.whenComplete(() async {
        downloadUrl = await ref.getDownloadURL();

        if (_formKey.currentState.validate()) {
          databaseService
              .updateExercise(
                  exerciseDocId: widget.exerciseDocId,
                  exercisePic: downloadUrl,
                  exerciseName: exerciseName,
                  exerciseDesc: exerciseDesc)
              .then((value) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: Theme.of(context).primaryColor,
                content: Text(
                  "Exercise Updated",
                  textAlign: TextAlign.center,
                ),
              ),
            );

            new Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.of(context).pop();
            });
          }).catchError((error) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                duration: Duration(microseconds: 3000),
                backgroundColor: Colors.red,
                content: Text(
                  "Failed to Update Exercise: $error",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          });
        }
      }).catchError((onError) {
        print(onError);
      });
    } else if (imgFile == null) {
      if (_formKey.currentState.validate()) {
        databaseService
            .updateExercise(
                exerciseDocId: widget.exerciseDocId,
                exercisePic: exerciseExistingPic,
                exerciseName: exerciseName,
                exerciseDesc: exerciseDesc)
            .then((value) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 1000),
              backgroundColor: Theme.of(context).primaryColor,
              content: Text(
                "Exercise Updated",
                textAlign: TextAlign.center,
              ),
            ),
          );

          new Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pop();
          });
        }).catchError((error) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(microseconds: 3000),
              backgroundColor: Colors.red,
              content: Text(
                "Failed to Update Exercise: $error",
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
      }
    }
  }

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
            key: _formKey,
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
                          // Image.network(
                          //   snapshotExerciseInfo.data["exercise_pic"],
                          //   height: 200,
                          //   fit: BoxFit.cover,
                          // ),
                          imgFile == null
                              ? Image.network(
                                  snapshotExerciseInfo.data["exercise_pic"] !=
                                          null
                                      ? snapshotExerciseInfo
                                          .data["exercise_pic"]
                                      : "https://firebasestorage.googleapis.com/v0/b/gymandfood-e71d1.appspot.com/o/exercise_loading_animation.gif?alt=media&token=84818a9f-18bc-4ad6-b8a4-3f7c3e45facd",
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  imgFile,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                          GestureDetector(
                            onTap: () => showOptionsDialog(context),
                            child: Icon(Icons.add_a_photo),
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
                                  textExerciseName = value;
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
                                  textExerciseDesc = value;
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
                                onTap: () {
                                  String exerciseName, exerciseDesc;
                                  if (textExerciseName != null)
                                    exerciseName = textExerciseName;
                                  else
                                    exerciseName = snapshotExerciseInfo
                                        .data["exercise_name"];
                                  if (textExerciseDesc != null)
                                    exerciseDesc = textExerciseDesc;
                                  else
                                    exerciseDesc = snapshotExerciseInfo
                                        .data["exercise_desc"];
                                  updateExercise(
                                      snapshotExerciseInfo.data["exercise_pic"],
                                      exerciseName,
                                      exerciseDesc);
                                },
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
