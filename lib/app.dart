import 'dart:ui';
import 'package:fitnesstracker/assignedExercisesPage/assigned_exercises.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/exerciseHistoryPage/exercise_history.dart';
import 'package:fitnesstracker/homePage/home_page.dart';
import 'package:flutter/material.dart';
import 'clientProfilePage/clientProfilePage.dart';
import 'destinations.dart';

// actual entry point into the app
class App extends StatefulWidget {
  final Client client;

  // Takes in the client object as a key that is passed in
  // from the login/registration page
  App({Key key, this.client}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin<App> {
  TabItem _currentTab = TabItem.today;
  Widget _currentBody;

  @override
  void initState() {
    super.initState();
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
            backgroundColor: Colors.white,
            icon: Icon(destination.icon, color: Colors.black,),
            title: Text(destination.title, style: TextStyle(color: Colors.black, fontSize: 11.5),),
          );
        }).toList(),
      ),
    );
  }

  void _setCurrentBody(TabItem currentTab) {
    switch(currentTab) {
      case TabItem.today:
        _currentBody =  HomePage(client: widget.client,);
        break;
      case  TabItem.exercises:
        _currentBody = AssignedExercisesPage(client: widget.client,);
        break;
      case TabItem.history:
        _currentBody = ExerciseHistoryPage(client: widget.client,);
        break;
      case TabItem.profile:
        _currentBody = ClientProfilePage(client: widget.client,);
    };
  }
}