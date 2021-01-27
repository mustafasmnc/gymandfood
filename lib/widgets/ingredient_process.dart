import 'package:flutter/material.dart';
import 'package:gymandfood/services/database.dart';

class IngredientProgress extends StatelessWidget {
  DatabaseService databaseService = DatabaseService();
  final String userId;
  final String ingredient;
  final int userDailyGoal;
  final double progress, width;
  final Color progressColor;

  IngredientProgress(
      {this.ingredient,
      this.userDailyGoal,
      this.progress,
      this.progressColor,
      this.width,
      this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseService.getDailyFoods(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            try {
              var ds = snapshot.data.docs;
              int sum = 0;

              for (int i = 0; i < ds.length; i++) {
                sum += ds[i]['food$ingredient'];
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ingredient.toUpperCase() + " " + "($sum)",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 10,
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Colors.grey[300]),
                          ),
                          Container(
                            height: 10,
                            width: userDailyGoal == 0
                                ? 0
                                : sum / userDailyGoal < 1
                                    ? width * (sum / userDailyGoal)
                                    : width,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: progressColor),
                          )
                        ],
                      ),
                      SizedBox(width: 5),
                      Text(userDailyGoal - sum > 0
                          ? "${userDailyGoal - sum}g left"
                          : "0g left")
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              );
            } catch (e) {
              print(e);
              return Center(
                child: Text("Error"),
              );
            }
          }
        });
  }
}
