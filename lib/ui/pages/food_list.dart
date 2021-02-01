import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/widgets/widgets.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: databaseService.getFilteredFoods(widget.foodCatId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data.docs.length == 0) {
            return Center(
              child: noData(0),
            );
          } else {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 0, right: 16, left: 16, bottom: 0),
              child: Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot fcs = snapshot.data.docs[index];
                      return OpenContainer(
                          closedColor: Colors.grey[200],
                          closedShape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          transitionDuration:
                              const Duration(milliseconds: 1500),
                          openBuilder: (context, _) {
                            return FoodDetailScreen(foodId: fcs["food_id"]);
                          },
                          closedBuilder: (context, openContainer) {
                            return GestureDetector(
                              onTap: openContainer,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 0),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(fcs["food_pic"]),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fcs["food_name"].length > 32
                                              ? fcs["food_name"]
                                                      .substring(0, 32) +
                                                  "..."
                                              : fcs["food_name"],
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
              ),
            );
          }
        },
      ),
    );
  }
}
