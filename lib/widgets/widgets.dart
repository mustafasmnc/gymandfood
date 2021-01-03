import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/model/user_exercises.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/ui/pages/workout_screen.dart';

DatabaseService databaseService = DatabaseService();

Widget submitButton({BuildContext context, String text, buttonWith}) {
  return Container(
    height: 50,
    alignment: Alignment.center,
    width: buttonWith != null ? buttonWith : MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

Widget dayCards(
    String userId,
    String dayName,
    String dayId,
    double height,
    double width,
    Color color1,
    Color color2,
    List<UserExercises> dayExercises) {
  return OpenContainer(
    closedElevation: 0,
    transitionDuration: const Duration(milliseconds: 1500),
    openShape: const ContinuousRectangleBorder(),
    transitionType: ContainerTransitionType.fade,
    closedColor: Color(0xFFE9E9E9),
    openBuilder: (context, _) {
      return WorkoutScreen(color1, userId, dayId);
    },
    closedBuilder: (context, VoidCallback openContainer) {
      return GestureDetector(
        // onTap: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => WorkoutScreen(dayExercises)));
        // },
        onTap: openContainer,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 150,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [color1, color2]),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(5, 5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  IconButton(
                      icon: Icon(
                        null,
                        color: Colors.white,
                      ),
                      onPressed: null)
                ],
              ),
              Container(
                  height: 60,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: databaseService.getAddedExercises(userId, dayId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                              fontSize: 16,
                            ),
                          ));
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot aue =
                                    snapshot.data.docs[index];
                                return Container(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          aue["exercisePic"],
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                );
                              });
                        }
                      }))
            ],
          ),
        ),
      );
    },
  );
}
