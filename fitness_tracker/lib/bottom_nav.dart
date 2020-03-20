import 'package:flutter/material.dart';

enum TabItem { today, exercises, history, profile}

Map<TabItem, String> tabName = {
  TabItem.today : 'Today',
  TabItem.exercises : 'Exercises',
  TabItem.history : 'History',
  TabItem.profile : 'Profile',
};

Map<TabItem, IconData> tabIcons = {
  TabItem.today : Icons.home,
  TabItem.exercises : Icons.directions_run,
  TabItem.history : Icons.today,
  TabItem.profile : Icons.account_circle,
};

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar (
      type: BottomNavigationBarType.shifting,
      items: [
        _buildItem(tabItem: TabItem.today),
        _buildItem(tabItem: TabItem.exercises),
        _buildItem(tabItem: TabItem.history),
        _buildItem(tabItem: TabItem.profile),
      ],
      onTap: (index) => onSelectTab(TabItem.values[index]),
    );
  }

  BottomNavigationBarItem _buildItem ({TabItem tabItem}) {
    String text = tabName[tabItem];
    IconData icon = tabIcons[tabItem];

    return BottomNavigationBarItem (
      icon: Icon(icon, color: _currentTabColor(item: tabItem)),
      title: Text(text, style: TextStyle(color: Colors.black)),
    );
  }

  Color _currentTabColor ({TabItem item}) {
    return (currentTab == item) ? Colors.black : Colors.grey;
  }
}