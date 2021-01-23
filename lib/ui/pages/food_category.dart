import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/helper/functions.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/ui/pages/food_list.dart';

String usertype;
Future<String> updateAction() async {
  String userType;
  await FirebaseFirestore.instance
      .collection("user")
      .doc(userId)
      .get()
      .then((value) {
    userType = value.data()['userType'];
    usertype = value.data()['userType'];
  });
  return Future.value(userType.toString());
}

class FoodCategoryPage extends StatefulWidget {
  @override
  _FoodCategoryPageState createState() => _FoodCategoryPageState();
}

String userId;

class _FoodCategoryPageState extends State<FoodCategoryPage> {
  DatabaseService databaseService = DatabaseService();
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
                      foodCategoryDocId: fcs.id,
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
      floatingActionButton: FutureBuilder(
          future: updateAction(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data == "admin"
                ? FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.add),
                    backgroundColor: Colors.green,
                  )
                : Text("");
          }),
    );
  }
}

class CategoryTile extends StatefulWidget {
  final String foodCategoryDocId;
  final String foodCategoryImg;
  final String foodCategoryTitle;
  final String foodCategoryDesc;
  final String foodCategoryId;

  const CategoryTile(
      {@required this.foodCategoryImg,
      @required this.foodCategoryTitle,
      @required this.foodCategoryDesc,
      @required this.foodCategoryId,
      @required this.foodCategoryDocId});
  // final FoodCategory foodCategory;

  // const CategoryTile({Key key, this.foodCategory}) : super(key: key);

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      height: 160,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.foodCategoryImg != null
                  ? widget.foodCategoryImg
                  : "https://firebasestorage.googleapis.com/v0/b/gymandfood-e71d1.appspot.com/o/food-icons-loading-animation.gif?alt=media&token=1e80bbc0-78f4-4ecf-a6c0-7958b3cfc7e4",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodList(
                            foodCatId: widget.foodCategoryId,
                          )));
            },
            onLongPress: () {
              usertype == "admin"
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodCategoryEdit(
                                foodCategoryDocId: widget.foodCategoryDocId,
                              )))
                  : null;
            },
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
}

class FoodCategoryEdit extends StatefulWidget {
  final String foodCategoryDocId;

  const FoodCategoryEdit({this.foodCategoryDocId});
  @override
  _FoodCategoryEditState createState() => _FoodCategoryEditState();
}

class _FoodCategoryEditState extends State<FoodCategoryEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text(widget.foodCategoryDocId)),
      ),
    );
  }
}
