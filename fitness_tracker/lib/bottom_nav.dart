import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
  BottomNavigation({Key key, this.currentTab, @required this.onSelectTab})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Color _profileAccentColour = Colors.deepOrange;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar (
      type: BottomNavigationBarType.fixed,
      backgroundColor: _profileAccentColour,// to be decided by user?
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
      backgroundColor: Colors.deepOrange,
      icon: Icon(icon),
      title: Text(text),
    );
  }
}