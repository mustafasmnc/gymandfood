import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/services/database.dart';

import 'food_detail_screen.dart';

class FoodList extends StatefulWidget {
  final String foodCatId;

  const FoodList({Key key, this.foodCatId}) : super(key: key);
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  DatabaseService databaseService = DatabaseService();
  @override
  void initState() {
    super.initState();
    //_filteredFoods =foods.where((i) => i.foodCatId == widget.foodCatId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: databaseService.getFilteredFoods(widget.foodCatId),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } 
          else{
            return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 32, right: 16, left: 16, bottom: 0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    //scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot fcs = snapshot.data.docs[index];
                      return OpenContainer(
                          closedShape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          transitionDuration: const Duration(milliseconds: 1500),
                          openBuilder: (context, _) {
                            return FoodDetailScreen(foodId: fcs["food_id"]);
                          },
                          closedBuilder: (context, openContainer) {
                            return GestureDetector(
                              onTap: openContainer,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                        color: Colors.black12,
                                      )
                                    ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  fcs["food_pic"]),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${fcs["food_name"]}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          //width: MediaQuery.of(context).size.width / 1.65,
                                          child: Text(
                                            "Calorie: ${fcs["food_cal"]}",
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      );
          }
      },
    );
  }
}
