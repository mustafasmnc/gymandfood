import 'package:flutter/material.dart';
import 'package:gymandfood/model/bottomNavigation.dart';
import 'package:gymandfood/model/tabItem.dart';
import 'package:gymandfood/ui/pages/body_parts.dart';
import 'package:gymandfood/ui/pages/food_category.dart';
import 'package:gymandfood/ui/pages/profile_screen.dart';

class App extends StatefulWidget {
  bool loggedIn;
  App({this.loggedIn});
  @override
  State<StatefulWidget> createState() => AppState(this.loggedIn);
}

class AppState extends State<App> {
  static int currentTab = 2;

  final List<TabItem> tabs = [
    TabItem(
      tabName: "Workout",
      icon: Icons.fitness_center,
      page: BodyParts(),
    ),
    TabItem(
      tabName: "Food Category",
      icon: Icons.restaurant_menu,
      page: FoodCategoryPage(),
    ),
    TabItem(
      tabName: "Profile",
      icon: Icons.person,
      page: ProfileScreen(),
    ),
  ];
  AppState(bool userId) {
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }
  void _selectTab(int index) {
    if (index == currentTab) {
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => currentTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[currentTab].key.currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (currentTab != 0) {
            //_selectTab(0);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        bottomNavigationBar:
            widget.loggedIn == false
                ? null
                : BottomNavigation(
                    onSelectTab: _selectTab,
                    tabs: tabs,
                  ),
      ),
    );
  }
}
