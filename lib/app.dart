import 'package:fitnesstracker/UserListPage/user_list_page.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/exerciseHistoryPage/exercise_history.dart';
import 'package:fitnesstracker/homePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'ProfilePage/profile_page.dart';
import 'destinations.dart';

// actual entry point into the app
class App<T extends Profile> extends StatefulWidget {
  final T client;

  // Takes in the client object as a key that is passed in
  // from the login/registration page
  App({Key key, this.client}) : super(key: key);

  @override
  _AppState createState() => _AppState<T>();
}

class _AppState<T extends Profile> extends State<App> {
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
        items: clientDestinationsList.map((Destination destination) {
          return BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(destination.icon, color: Colors.black,),
            title: Text(
              destination.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 11.5
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _setCurrentBody(TabItem currentTab) {
    switch(currentTab) {
      case TabItem.today:
        _currentBody =  HomePage<T>(user: widget.client,);
        break;
      case  TabItem.exercises:
        _currentBody = UserListPage<T>(user: widget.client,);
        break;
      case TabItem.history:
        _currentBody = ExerciseHistoryPage(client: widget.client,);
        break;
      case TabItem.profile:
        _currentBody = ProfilePage<T>(client: widget.client,);
        break;
    }
  }
}