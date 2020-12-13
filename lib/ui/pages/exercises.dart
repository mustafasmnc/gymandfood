import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    //filteredExercises = exercises.where((i) => i.exerciseMuscleId == widget.exerciseMuscleId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: databaseService.getExercises(widget.exerciseMuscleId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot els = snapshot.data.docs[index];
                    return ExerciseTile(
                      exerciseId: els["exercise_id"],
                      exercisePic: els["exercise_pic"],
                      exerciseName: els["exercise_name"],
                      exerciseDesc: els["exercise_desc"],
                      exerciseMuscleId: els["exercise_muscle_id"],
                      exerciseMuscle: els["exercise_muscle"],
                    );
                  });
            }
          }),
    );
  }
}
