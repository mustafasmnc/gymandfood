import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/widgets/widgets.dart';

import 'food_detail_screen.dart';

DatabaseService databaseService = DatabaseService();

class FoodList extends StatefulWidget {
  final String foodCatId;

  const FoodList({Key key, this.foodCatId}) : super(key: key);
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  void initState() {
    super.initState();
  }

  String textSearch;
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextField(
            controller: _controller,
            decoration: new InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (textSearch != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchItem(
                                    searchKey: textSearch,
                                    foodCatId: widget.foodCatId,
                                  )));
                    }
                  }),
              contentPadding:
                  EdgeInsets.only(left: 10, bottom: 0, top: 15, right: 10),
              hintText: "Search",
            ),
            onChanged: (value) {
              textSearch = value;
            },
            textAlign: TextAlign.left,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.search,
        //       color: Colors.blue,
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) =>
        //                   SearchItem(arama: textExerciseName)));
        //     },
        //   ),
        // ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
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
              try {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 0, right: 16, left: 16, bottom: 0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot fcs = snapshot.data.docs[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FoodDetailScreen(
                                          foodId: fcs["food_id"]))),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: [
                                        Color(0xFF636FA4),
                                        Color(0xFFFFFFFF)
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(
                                          5, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(vertical: 0),
                                padding: EdgeInsets.only(left: 00, right: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(fcs["food_pic"]),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                      ),
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
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          //width: MediaQuery.of(context).size.width / 1.65,
                                          child: Text(
                                            "Calorie: ${fcs["food_cal"]}",
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black45),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      }),
                );
              } catch (e) {
                print(e);
                return Center(
                  child: Text("Error"),
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class SearchItem extends StatefulWidget {
  final String searchKey, foodCatId;

  const SearchItem({Key key, this.searchKey, this.foodCatId}) : super(key: key);
  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              databaseService.searchItem(widget.searchKey, widget.foodCatId),
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
              try {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 0, right: 16, left: 16, bottom: 0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot fcs = snapshot.data.docs[index];
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FoodDetailScreen(
                                          foodId: fcs["food_id"]))),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                      colors: [
                                        Color(0xFF636FA4),
                                        Color(0xFFFFFFFF)
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: Offset(
                                          5, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(vertical: 0),
                                padding: EdgeInsets.only(left: 0, right: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(fcs["food_pic"]),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                      ),
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
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          //width: MediaQuery.of(context).size.width / 1.65,
                                          child: Text(
                                            "Calorie: ${fcs["food_cal"]}",
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.black45),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      }),
                );
              } catch (e) {
                print(e);
                return Center(
                  child: Text("Error"),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
