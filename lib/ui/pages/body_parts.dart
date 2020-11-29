import 'package:flutter/material.dart';
import 'package:gymandfood/model/body_muscles.dart';
import 'package:gymandfood/widgets/body_muscle_tile.dart';

class BodyParts extends StatefulWidget {
  @override
  _BodyPartsState createState() => _BodyPartsState();
}

class _BodyPartsState extends State<BodyParts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Body Muscles",
            style: TextStyle(fontSize: 26, color: Colors.black54),
          ),
          Divider(color: Colors.black),
          bodyMusclesList(),
        ],
      ),
    );
  }

  Widget bodyMusclesList() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: bodyMuscles.length,
          itemBuilder: (context, index) {
            return BodyMuscleTile(
              bodyMuscleImage: bodyMuscles[index].bodyMuscleImage,
              bodyMuscleName: bodyMuscles[index].bodyMuscleName,
              bodyMuscleDesc: bodyMuscles[index].bodyMuscleDesc,
              bodyMuscleId: bodyMuscles[index].bodyMuscleId,
            );
          }),
    );
  }
}
