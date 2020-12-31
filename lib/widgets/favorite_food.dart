import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/services/database.dart';
import 'package:gymandfood/services/favorite_database.dart';

DatabaseService databaseService = DatabaseService();

class FavoriteFood extends StatelessWidget {
  
  FavoriteDatabase favoriteDatabase = FavoriteDatabase();
  final List foodsId;

  FavoriteFood({Key key, this.foodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("foodsId: $foodsId");
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.3,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MEALS FOR TODAY",
            style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
          SizedBox(height: height / 150),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // for (int i = 0; i < foodsId.length; i++)
                  //   _FoodCard(foodId: foodsId[i]),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

getFoodDetail(String id) {
  var data = databaseService.getFoodDetail(id);
  print(data["food_name"]);
}

class _FoodCard extends StatelessWidget {
  final String foodId;

  const _FoodCard({@required this.foodId});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: databaseService.getFoodDetail(foodId),
      builder: (context, snapshot) {
        DocumentSnapshot bms = snapshot.data.docs[0];
        return Text(bms['food_name']);
      },
    ));


    // return Container(
    //   margin: const EdgeInsets.only(right: 10, bottom: 10),
    //   child: Material(
    //       borderRadius: BorderRadius.all(Radius.circular(20)),
    //       elevation: 4,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //           Flexible(
    //             fit: FlexFit.tight,
    //             child: OpenContainer(
    //               closedShape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.all(Radius.circular(20))),
    //               transitionDuration: const Duration(milliseconds: 1500),
    //               openBuilder: (context, _) {
    //                 //return FoodDetailScreen(food: food);
    //               },
    //               closedBuilder: (context, openContainer) {
    //                 return GestureDetector(
    //                   onTap: openContainer,
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.all(
    //                       const Radius.circular(20),
    //                     ),
    //                     child: Image.network(
    //                       food.foodPic,
    //                       width: 120,
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //           Flexible(
    //               fit: FlexFit.tight,
    //               child: Container(
    //                 padding: EdgeInsets.only(
    //                   left: 5,
    //                   top: 5,
    //                   right: 5,
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       food.foodName.length > 16
    //                           ? food.foodName.substring(0, 16) + ".."
    //                           : food.foodName,
    //                       style: const TextStyle(
    //                         fontSize: 14,
    //                         color: Colors.black,
    //                         fontWeight: FontWeight.w700,
    //                       ),
    //                       maxLines: 1,
    //                     ),
    //                     //SizedBox(height: height / 150),
    //                     Text(
    //                       "Calorie: " + food.foodCal,
    //                       style: const TextStyle(
    //                         fontSize: 13,
    //                         color: Colors.blueGrey,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                       maxLines: 1,
    //                     ),
    //                     Text(
    //                       "Protein: " + food.foodProtein,
    //                       style: const TextStyle(
    //                         fontSize: 13,
    //                         color: Colors.blueGrey,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                       maxLines: 1,
    //                     ),
    //                     Text(
    //                       "Fat: " + food.foodFat,
    //                       style: const TextStyle(
    //                         fontSize: 13,
    //                         color: Colors.blueGrey,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                       maxLines: 1,
    //                     ),
    //                     SizedBox(height: height / 100),
    //                   ],
    //                 ),
    //               )),
    //         ],
    //       )),
    // );
  }
}
