import 'package:flutter/material.dart';
import 'package:gymandfood/model/exercises.dart';
import 'package:gymandfood/widgets/body_muscle_tile.dart';
import 'package:gymandfood/widgets/exercise_tile.dart';

class Exercises extends StatefulWidget {
  final String exerciseMuscleId;

  const Exercises({Key key, this.exerciseMuscleId}) : super(key: key);
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  List<Exercise> filteredExercises = [];
  @override
  void initState() {
    super.initState();
    filteredExercises = exercises
        .where((i) => i.exerciseMuscleId == widget.exerciseMuscleId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            filteredExercises[0].exerciseMuscle,
            style: TextStyle(fontSize: 26, color: Colors.black54),
          ),
          Divider(color: Colors.black),
          exerciseList(),
        ],
      ),
    );
  }

  Widget exerciseList() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: filteredExercises.length,
          itemBuilder: (context, index) {
            return ExerciseTile(
              exerciseId: filteredExercises[index].exerciseId,
              exercisePic: filteredExercises[index].exercisePic,
              exerciseName: filteredExercises[index].exerciseName,
              exerciseDesc: filteredExercises[index].exerciseDesc,
              exerciseMuscleId:filteredExercises[index].exerciseMuscleId,
              exerciseMuscle:filteredExercises[index].exerciseMuscle,
            );
          }),
    );
  }
}
