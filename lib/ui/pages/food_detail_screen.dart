import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/model/food.dart';
import 'package:gymandfood/services/database.dart';

class FoodDetailScreen extends StatefulWidget {
  final String foodId;

  const FoodDetailScreen({Key key, this.foodId}) : super(key: key);
  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  DatabaseService databaseService = DatabaseService();
  //var catName;
  // var healthString=widget.food.foodHealth;
  // var health=int.parse(healthString);
  // int val =int.tryParse(widget.food.foodHealth);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: databaseService.getFoodDetail(widget.foodId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              DocumentSnapshot items = snapshot.data.docs[0];
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    snap: true,
                    floating: true,
                    backgroundColor: const Color(0xFF200087),
                    expandedHeight: 250,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    flexibleSpace: FlexibleSpaceBar(
                      background: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(40)),
                        child: Image.network(
                          items["food_pic"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        //SizedBox(height: 10),
                        ListTile(
                          title: Text(
                            items["food_cat_name"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                          subtitle: Text(
                            items["food_name"],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Calorie: " + items["food_cal"],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _IngredientProgress(
                                    width: 50,
                                    ingredient: "Health",
                                    progress: items["food_health"],
                                    progressColor: Colors.green,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 32,
                          ),
                          child: Text(
                            items["food_desc"],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}

class _IngredientProgress extends StatelessWidget {
  final String ingredient, progress;
  final double width;
  final Color progressColor;
  const _IngredientProgress(
      {this.ingredient, this.progress, this.progressColor, this.width});
  @override
  Widget build(BuildContext context) {
    var val = double.parse(progress);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          ingredient.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 2),
        Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 5,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey[400]),
                ),
                Container(
                  height: 5,
                  width: width * ((val / 10) * 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: progressColor),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 6),
      ],
    );
  }
}
