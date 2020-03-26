import 'package:flutter/material.dart';
import 'bottom_nav.dart';
import 'home_page.dart' as homePage;
import 'assigned_exercises.dart' as assignedExercises;
import 'exercise_history.dart' as exerciseHistory;

class App extends StatefulWidget {
  App ({Key key, this.title}) : super(key: key);

  final String title;

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  TabItem _currentTab = TabItem.today;
  Map <TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.today : GlobalKey<NavigatorState>(),
    TabItem.exercises : GlobalKey<NavigatorState>(),
    TabItem.history : GlobalKey<NavigatorState>(),
    TabItem.profile : GlobalKey<NavigatorState> (),
  };

  void _selectTab(TabItem selectedItem) {
    setState(() {
      _currentTab = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.deepPurple,
      alignment: Alignment.center,
      child: FlatButton(
        child: Text(
          'Home',
          style: TextStyle(fontSize: 32.0, color: Colors.white),
        ),
      ),
    );
  }
}
