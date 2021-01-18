import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/ui/pages/food_list.dart';

class FoodCategoryPage extends StatefulWidget {
  String userType;

  FoodCategoryPage({this.userType});
  @override
  _FoodCategoryPageState createState() => _FoodCategoryPageState();
}

class _FoodCategoryPageState extends State<FoodCategoryPage> {
  DatabaseService databaseService = DatabaseService();
  String userId;
  @override
  void initState() {
    HelperFunctions.getUserLoggedInID().then((value) {
      setState(() {
        userId = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: databaseService.getFoodCategorySnapshot(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              //child: Expanded(
              //child: RefreshIndicator(
              //  key: _refreshIndicatorKey,
              // onRefresh: refreshList,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot fcs = snapshot.data.docs[index];
                    return CategoryTile(
                      foodCategoryImg: fcs["food_category_pic"],
                      foodCategoryTitle: fcs["food_category_name"],
                      foodCategoryDesc: fcs["food_category_desc"],
                      foodCategoryId: fcs["food_category_id"],
                    );
                  }),
              //),
              //),
            );
          }
        },
      ),
      floatingActionButton: StreamBuilder(
          stream: databaseService.getUserInfo(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("");
            } else {
              if (snapshot.data['userType'] == "admin")
                return FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                );
              else
                return Text("");
            }
          }),
    );
  }
}

class CategoryTile extends StatefulWidget {
  final String foodCategoryImg;
  final String foodCategoryTitle;
  final String foodCategoryDesc;
  final String foodCategoryId;

  const CategoryTile(
      {@required this.foodCategoryImg,
      @required this.foodCategoryTitle,
      @required this.foodCategoryDesc,
      @required this.foodCategoryId});
  // final FoodCategory foodCategory;

  // const CategoryTile({Key key, this.foodCategory}) : super(key: key);

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodList(
                      foodCatId: widget.foodCategoryId,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        height: MediaQuery.of(context).size.height / 4,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.foodCategoryImg,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.foodCategoryTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Text(
                    widget.foodCategoryDesc,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
