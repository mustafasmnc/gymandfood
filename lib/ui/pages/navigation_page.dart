import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/ui/pages/exercises.dart';
import 'package:gymandfood/ui/pages/food_category.dart';
import 'package:gymandfood/ui/pages/profile_screen.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedPage = 0;
  final _pageOptions = [ProfileScreen(), FoodCategoryPage(), Exercises()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedPage,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (int index) => setState(() {
          _selectedPage = index;
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.restaurant_menu),
            title: Text('Food'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.fitness_center),
            title: Text('Workout'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex:_selectedPage,
      //   onTap: (int index){
      //     setState(() {
      //         _selectedPage=index;
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       title: Text("Person")
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text("home")
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.work),
      //       title: Text("work")
      //     ),
      //   ],
      // ),
    );
  }
}
