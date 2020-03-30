import 'package:flutter/material.dart';
import 'bottom_nav.dart';
import 'tab_navigator.dart';

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
    if (selectedItem == _currentTab) {
      // pop to first route
      _navigatorKeys[selectedItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = selectedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab].currentState.maybePop();

        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.today) {
            _selectTab(TabItem.today);

            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },

      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.today),
          _buildOffstageNavigator(TabItem.history),
          _buildOffstageNavigator(TabItem.exercises),
          _buildOffstageNavigator(TabItem.profile),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
