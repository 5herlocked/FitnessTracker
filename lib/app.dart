import 'package:fitnesstracker/UserListPage/user_list_page.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/exerciseHistoryPage/exercise_history.dart';
import 'package:fitnesstracker/homePage/home_page.dart';
import 'package:fitnesstracker/loginRegistrationPage/login_register_page.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'ProfilePage/profile_page.dart';
import 'destinations.dart';
import 'entities/trainer.dart';

// actual entry point into the app
class App<T extends Profile> extends StatefulWidget {
  T user;
  final bool trainerView;

  // Takes in the client object as a key that is passed in
  // from the login/registration page
  App({Key key, this.user, this.trainerView}) : super(key: key);

  @override
  _AppState createState() => _AppState<T>();
}

class _AppState<T extends Profile> extends State<App> {
  var _currentTab;
  int _currentIndex = 0;
  Widget _currentBody;
  List<Destination> _currentDestinations;

  @override
  void initState() {
    super.initState();
    if (widget.trainerView) {
      _currentTab = ClientViewTabItem.profile;
      _currentDestinations = Destination.trainerClientViewDestinationList;
    } else {
      switch (T) {
        case Client:
          _currentTab = ClientTabItem.today;
          _currentDestinations = Destination.clientDestinationsList;
          break;
        case Trainer:
          _currentTab = TrainerTabItem.today;
          _currentDestinations = Destination.trainerDestinationsList;
          break;
      }
    }
    _setCurrentBody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentBody,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar () {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentTab = _getNextTab(index);
          _setCurrentBody();
        });
      },
      items: _getItems(_currentDestinations),
    );
  }

  void _setCurrentBody() {
    if (widget.trainerView) {
      switch(_currentTab) {
        case ClientViewTabItem.profile:
          _currentBody = ProfilePage<Client>(user: widget.user, isAlternateView: true,);
          break;
        case ClientViewTabItem.exercises:
          _currentBody = UserListPage<Client>(user: widget.user, isTrainerView: true,);
          break;
        case ClientViewTabItem.history:
          _currentBody = ExerciseHistoryPage(client: widget.user,);
          break;
      }
    } else if (T == Client) {
      switch(_currentTab) {
        case ClientTabItem.today:
          _currentBody = HomePage<Client>(user: widget.user,);
          break;
        case ClientTabItem.exercises:
          _currentBody = UserListPage<Client>(user: widget.user,);
          break;
        case ClientTabItem.history:
          _currentBody = ExerciseHistoryPage();
          break;
        case ClientTabItem.profile:
          _currentBody = ProfilePage<Client>(user: widget.user, isAlternateView: false,);
          break;
      }
    } else if (T == Trainer) {
      switch(_currentTab) {
        case TrainerTabItem.today:
          _currentBody = HomePage<Trainer>(user: widget.user,);
          break;
        case TrainerTabItem.clientList:
          _currentBody = UserListPage<Trainer>(user: widget.user, isTrainerView: false,);
          break;
        case TrainerTabItem.profile:
          _currentBody = ProfilePage<Trainer>(user: widget.user, isAlternateView: false,);
          break;
      }
    }
  }

  _getNextTab (int index) {
    _currentIndex = index;
    return _currentDestinations.elementAt(index).tabItem;
  }

  List<BottomNavigationBarItem> _getItems(List<Destination> destinations) {
    return destinations.map((Destination destination) {
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
    }).toList();
  }
}