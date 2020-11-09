import 'package:flutter/material.dart';
import 'package:gymandfood/model/meal.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color(0xFFE9E9E9),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(40),
          ),
          child: BottomNavigationBar(
            currentIndex: 1,
            iconSize: 30,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            //selectedIconTheme: IconThemeData(color: const Color(0xFF200087)),
            //unselectedIconTheme: IconThemeData(color: Colors.black45),
            selectedItemColor: const Color(0xFF200087),
            unselectedItemColor: Colors.black45,
            selectedLabelStyle: TextStyle(
              color: Colors.pink,
              fontSize: 16,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.yellow,
              fontSize: 14,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              height: height * 0.33,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: const Radius.circular(40),
                ),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                top: height * 0.35,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: height * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MEALS FOR TODAY",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      SizedBox(height: height / 150),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < foods.length; i++)
                                _FoodCard(food: foods[i]),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.blueAccent,
                      ))
                    ],
                  ),
                ))
          ],
        ));
  }
}

class _FoodCard extends StatelessWidget {
  final Food food;

  const _FoodCard({@required this.food});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(20),
                      ),
                      child: Image.network(
                        food.foodPic,
                        width: 140,
                        fit: BoxFit.cover,
                      ))),
              Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 8,
                      top: 10,
                      right: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          food.foodName.length > 18
                              ? food.foodName.substring(0, 18) + "..."
                              : food.foodName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                        ),
                        //SizedBox(height: height / 150),
                        Text(
                          "Calorie: " + food.foodCal,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          "Protein: " + food.foodProtein,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          "Fat: " + food.foodFat,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                        ),
                        SizedBox(height: height / 100),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
