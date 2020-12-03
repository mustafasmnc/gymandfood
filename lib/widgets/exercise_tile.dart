import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gymandfood/model/user_exercises.dart';

class ExerciseTile extends StatelessWidget {
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
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                exercisePic,
                fit: BoxFit.contain,
              ),
            ),
            //SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exerciseName,
                  style: TextStyle(
                    color: Colors.black54,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        dayButton("Mon"),
                                        dayButton("Tue"),
                                        dayButton("Wed"),
                                        dayButton("Thu"),
                                        dayButton("Fri"),
                                        dayButton("Sat"),
                                        dayButton("Sun"),
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
            //SizedBox(height: 7),
            Text(exerciseDesc,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,
                )),
          ],
        ),
      ),
    );
  }

  Widget dayButton(String dayName) {
    UserExercises userExercises = UserExercises();
    return GestureDetector(
        onTap: () {
          userExercises.exerciseId = exerciseId;
          userExercises.exerciseName = exerciseName;
          userExercises.exerciseSetRepeat = "4 Set - 10 Repeat";
          userExercises.exercisePic = exerciseMuscleId == "1"
              ? "assets/chest.jpg"
              : exerciseMuscleId == "2"
                  ? "assets/back1.jpg"
                  : exerciseMuscleId == "3"
                      ? "assets/shoulder.jpg"
                      : exerciseMuscleId == "4"
                          ? "assets/biceps.jpg"
                          : exerciseMuscleId == "5"
                              ? "assets/triceps.jpg"
                              : exerciseMuscleId == "6"
                                  ? "assets/leg1.jpg"
                                  : exerciseMuscleId == "7"
                                      ? "assets/abdominal.jpg"
                                      : "assets/rest.png";
          userExercises.exerciseMuscle = exerciseMuscle;
          userExercises.exerciseMuscleId = exerciseMuscleId;
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
          print(userExercises.exercisePic);
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
