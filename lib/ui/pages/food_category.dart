import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gymandfood/model/food_category.dart';

class FoodCategory extends StatefulWidget {
  @override
  _FoodCategoryState createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Food Categories",
              style: TextStyle(fontSize: 26, color: Colors.black54),
            ),
            Divider(color: Colors.black),
            foodCategoryList(),
          ],
        ),
      ),
    );
  }

  Widget foodCategoryList() {
    return Expanded(
          child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: foodCategories.length,
          itemBuilder: (context, index) {
            return CategoryTile(
              foodCategoryImg: foodCategories[index].foodCategoryImage,
              foodCategoryTitle: foodCategories[index].foodCategoryName,
              foodCategoryDesc: foodCategories[index].foodCategoryDesc,
              foodCategoryId: foodCategories[index].foodCategoryId,
            );
          }),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String foodCategoryImg;
  final String foodCategoryTitle;
  final String foodCategoryDesc;
  final String foodCategoryId;

  const CategoryTile(
      {@required this.foodCategoryImg,
      @required this.foodCategoryTitle,
      @required this.foodCategoryDesc,
      @required this.foodCategoryId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => PlayQuiz(quizId: foodCategoryId)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        height: MediaQuery.of(context).size.height / 4,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                foodCategoryImg,
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
                    foodCategoryTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 80),
                  Text(
                    foodCategoryDesc,
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
