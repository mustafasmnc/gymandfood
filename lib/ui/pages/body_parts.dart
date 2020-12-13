import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/widgets/body_muscle_tile.dart';
import 'package:gymandfood/services/database.dart';

class BodyParts extends StatefulWidget {
  @override
  _BodyPartsState createState() => _BodyPartsState();
}

class _BodyPartsState extends State<BodyParts> {
  DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
          stream: databaseService.getBodyMuscles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot bms = snapshot.data.docs[index];
                      return BodyMuscleTile(
                        bodyMuscleImage: bms["muscle_pic"],
                        bodyMuscleName: bms["muscle_name"],
                        bodyMuscleDesc: bms["muscle_desc"],
                        bodyMuscleId: bms["muscle_id"],
                      );
                    }),
              );
            }
          }),
    );
  }
}
