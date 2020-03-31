import 'package:flutter/material.dart';
import 'destinations.dart';
import 'profile.dart';

// actual entry point into the app
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin<App> {
  Profile _currentProfile = Profile()
  TabItem _currentTab = TabItem.today;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: IndexedStack(
            index: TabItem.values.indexOf(_currentTab),
            children: allDestinationsList.map((Destination destination) {
              return DestinationView(destination: destination,);
            }).toList(),
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: TabItem.values.indexOf(_currentTab),
        onTap: (int index) {
          setState(() {
            _currentTab = TabItem.values[index];
          });
        },
        items: allDestinationsList.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon),
            backgroundColor: destination.color,
            title: Text(destination.title),
          );
        }).toList(),
      ),
    );
  }

}