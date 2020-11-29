import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/model/food.dart';

import 'food_detail_screen.dart';

class FoodList extends StatefulWidget {
  final String foodCatId;

  const FoodList({Key key, this.foodCatId}) : super(key: key);
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  List<Food> _filteredFoods = [];
  @override
  void initState() {
    super.initState();
    _filteredFoods =
        foods.where((i) => i.foodCatId == widget.foodCatId).toList();
  }

  @override
  Widget build(BuildContext context) {
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
                  itemCount: _filteredFoods.length,
                  itemBuilder: (context, i) {
                    // return Padding(
                    //   padding: EdgeInsets.only(bottom: 5),
                    //   child: Card(
                    //     color: Color(0xFF26547C).withOpacity(.5),
                    //     child: ListTile(
                    //       leading: ClipRRect(
                    //         borderRadius: BorderRadius.circular(10),
                    //         child: Image.network(
                    //           _filteredFoods[i].foodPic,
                    //           width: 50,
                    //           height: 50,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //       title: Text(
                    //         _filteredFoods[i].foodName,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.w800,
                    //           fontSize: 18,
                    //         ),
                    //       ),
                    //       subtitle: Text(
                    //         "Calorie: "+_filteredFoods[i].foodCal,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       // trailing: ClipRRect(
                    //       //   borderRadius: BorderRadius.circular(10),
                    //       //   child: Image.asset(
                    //       //     widget.workouts[i].exercisePic,
                    //       //     width: 50,
                    //       //     height: 50,
                    //       //     fit: BoxFit.cover,
                    //       //   ),
                    //       // ),
                    //     ),
                    //   ),
                    // );
                    return OpenContainer(
                        closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        transitionDuration: const Duration(milliseconds: 1500),
                        openBuilder: (context, _) {
                          return FoodDetailScreen(food: _filteredFoods[i]);
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
                                                _filteredFoods[i].foodPic),
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
                                        "${_filteredFoods[i].foodName}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        //width: MediaQuery.of(context).size.width / 1.65,
                                        child: Text(
                                          "Calorie: ${_filteredFoods[i].foodCal}",
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
}
