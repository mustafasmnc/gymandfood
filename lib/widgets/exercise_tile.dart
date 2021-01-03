import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
                                                print(
                                                    "Set: ${exerciseSet.text}, Repeat: ${exerciseRepeat.text}, ExerciseID: ${widget.exerciseId}");
                                                databaseService.addExercise(
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
                                                print(
                                                    "Set: ${exerciseSet.text}, Repeat: ${exerciseRepeat.text}, ExerciseID: ${widget.exerciseId}");
                                                databaseService.addExercise(
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
                                                print(
                                                    "Set: ${exerciseSet.text}, Repeat: ${exerciseRepeat.text}, ExerciseID: ${widget.exerciseId}");
                                                databaseService.addExercise(
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
                                                print(
                                                    "Set: ${exerciseSet.text}, Repeat: ${exerciseRepeat.text}, ExerciseID: ${widget.exerciseId}");
                                                databaseService.addExercise(
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
                                                print(
                                                    "Set: ${exerciseSet.text}, Repeat: ${exerciseRepeat.text}, ExerciseID: ${widget.exerciseId}");
                                                databaseService.addExercise(
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
                                                print(
                                                    "Set: ${exerciseSet.text}, Repeat: ${exerciseRepeat.text}, ExerciseID: ${widget.exerciseId}");
                                                databaseService.addExercise(
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
                                                print(
                                                    "Set: ${exerciseSet.text}, Repeat: ${exerciseRepeat.text}, ExerciseID: ${widget.exerciseId}");
                                                databaseService.addExercise(
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
