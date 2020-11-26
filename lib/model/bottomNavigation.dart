import 'package:flutter/material.dart';
import 'package:gymandfood/model/tabItem.dart';
import 'package:gymandfood/ui/pages/app.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    this.onSelectTab,
    this.tabs,
  });
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[200],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // iconSize: 22,
      // selectedFontSize: 0,
      // unselectedFontSize: 0,
      // selectedItemColor: const Color(0xFF200087),
      // unselectedItemColor: Colors.black45,
      // selectedLabelStyle: TextStyle(
      //   fontSize: 16,
      // ),
      // unselectedLabelStyle: TextStyle(
      //   fontSize: 14,
      // ),
      // selectedIconTheme: IconThemeData(size: 28),
      type: BottomNavigationBarType.fixed,
      items: tabs
          .map(
            (e) => _buildItem(
              index: e.getIndex(),
              icon: e.icon,
              tabName: e.tabName,
            ),
          )
          .toList(),
      onTap: (index) => onSelectTab(
        index,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(
      {int index, IconData icon, String tabName}) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _tabColor(index: index),
        size: _tabSize(index: index),
      ),
      title: Text(
        tabName,
        style: TextStyle(
          color: _tabColor(index: index),
          fontSize: 12,
        ),
      ),
    );
  }

  Color _tabColor({int index}) {
    return AppState.currentTab == index ? Colors.blue : Colors.grey;
  }

  double _tabSize({int index}) {
    return AppState.currentTab == index ? 26 : 22;
  }
}
