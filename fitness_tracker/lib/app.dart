import 'dart:ui';

import 'package:fitnesstracker/homePage/home_page.dart';
import 'package:flutter/material.dart';
import 'destinations.dart';
import 'entities/client_profile.dart';

// actual entry point into the app
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin<App> {
  ClientProfile _currentProfile = ClientProfile(
    id: 1,
    firstName: "Shardul",
    lastName: "Vaidya",
    emailID: "cam.v737@gmail.com",
    emergencyPhone: "9999999999",
    profilePicture: "https://picsum.photos/id/237/200/300",
    phoneNumber: "7703300826",
    trainerId: 0
  );
  TabItem _currentTab = TabItem.today;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(profile: _currentProfile,),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: TabItem.values.indexOf(_currentTab),
        onTap: (int index) {
          setState(() {
            _currentTab = TabItem.values[index];
          });
        },
        items: allDestinationsList.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(destination.icon, color: Colors.black,),
            title: Text(destination.title, style: TextStyle(color: Colors.black),),
          );
        }).toList(),
      ),
    );
  }
}