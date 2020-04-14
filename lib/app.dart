import 'package:fitnesstracker/assignedExercisesPage/assigned_exercises.dart';
import 'package:fitnesstracker/exerciseHistoryPage/exercise_history.dart';
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
  ClientProfile _currentProfile;
  TabItem _currentTab = TabItem.today;
  Widget _currentBody;

  @override
  void initState() {
    super.initState();
    _getProfile();
    _setCurrentBody(_currentTab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentBody,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: TabItem.values.indexOf(_currentTab),
        onTap: (int index) {
          setState(() {
            _currentTab = TabItem.values[index];
            _setCurrentBody(_currentTab);
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

  void _getProfile() {
    _currentProfile = ClientProfile(
        id: 1,
        firstName: "Shardul",
        lastName: "Vaidya",
        emailID: "cam.v737@gmail.com",
        emergencyPhone: "9999999999",
        profilePicture: "https://picsum.photos/id/237/200/300",
        phoneNumber: "7703300826",
        trainerId: 0
    );
  }

  void _setCurrentBody(TabItem currentTab) {
    switch(currentTab) {
      case TabItem.today:
        _currentBody =  HomePage(profile: _currentProfile,);
        break;
      case  TabItem.exercises:
        _currentBody = AssignedExercisesPage(profile: _currentProfile,);
        break;
      case TabItem.history:
        _currentBody = ExerciseHistoryPage(profile: _currentProfile,);
        break;
      case TabItem.profile:
        //_currentBody = ClientProfilePage(profile: _currentProfile,);
    };
  }
}