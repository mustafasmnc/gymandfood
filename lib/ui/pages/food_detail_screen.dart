import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/services/database.dart';

class FoodDetailScreen extends StatefulWidget {
  final String foodId;

  const FoodDetailScreen({Key key, this.foodId}) : super(key: key);
  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  DatabaseService databaseService = DatabaseService();
  bool dialVisible = true;
  String foodName, foodPic, foodCal, foodProtein, foodCarb, foodFat;
  String userId;
  bool isLiked = false;

  @override
  void initState() {
    HelperFunctions.getUserLoggedInID().then((value) {
      setState(() {
        userId = value;
        checkIfLikedOrNot(value);
      });
    });

    super.initState();
  }

  checkIfLikedOrNot(String userId) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .collection("favorite_foods")
        .doc(widget.foodId)
        .get()
        .then((value) {
      setState(() {
        isLiked = value.exists;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: databaseService.getFoodDetail(widget.foodId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                DocumentSnapshot items = snapshot.data.docs[0];
                foodName = items['food_name'];
                foodPic = items['food_pic'];
                foodCal = items['food_cal'];
                foodCarb = items['food_carb'];
                foodProtein = items['food_protein'];
                foodFat = items['food_fat'];
                try {
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        iconTheme: IconThemeData(color: Colors.black),
                        elevation: 0,
                        snap: true,
                        pinned: false,
                        floating: true,
                        backgroundColor: const Color(0xFF200087),
                        expandedHeight: 250,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        flexibleSpace: FlexibleSpaceBar(
                          background: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(40)),
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
                              title: StreamBuilder(
                                  stream: databaseService.getFoodCategoryName(
                                      items["food_cat_id"]),
                                  builder: (context, snapshotCatName) {
                                    if (snapshotCatName.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text("Loading...");
                                    } else
                                      try {
                                        return Text(
                                          snapshotCatName.data.docs[0]
                                              ["food_category_name"],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                        );
                                      } catch (e) {
                                        print(e);
                                        return Center(
                                          child: Text("Error"),
                                        );
                                      }
                                  }),
                              subtitle: Text(
                                items["food_name"],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                } catch (e) {
                  print(e);
                  return Center(
                    child: Text("Error"),
                  );
                }
              }
            }),
      ),
      floatingActionButton: buildSpeedDial(),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.favorite,
              color: isLiked == true ? Colors.red : Colors.white),
          backgroundColor: Colors.red[200],
          onTap: () {
            if (isLiked == false) {
              databaseService.addFavoriteFood(userId, widget.foodId, foodName,
                  foodPic, foodCal, foodProtein, foodCarb, foodFat);
              setState(() {
                isLiked = true;
              });
            } else {
              databaseService.removeFavoriteFood(userId, widget.foodId);
              setState(() {
                isLiked = false;
              });
            }
          },
          label: isLiked == true ? 'Remove Favorite' : 'Add Favorite',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.red,
        ),
        SpeedDialChild(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () {
            databaseService.addDailyFood(userId, widget.foodId, foodPic,
                foodName, foodCal, foodProtein, foodCarb, foodFat);
          },
          label: "Add Today's Meal",
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.green,
        ),
      ],
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
