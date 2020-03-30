import 'package:flutter/material.dart';
import 'bottom_nav.dart';
import 'assigned_exercises.dart';
import 'exercise_history.dart';
import 'exercise_detail.dart';
import 'home_page.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String assignedExercise = '/assignedExercise';
  static const String exerciseHistory = '/exerciseHistory';
  static const String exerciseDetail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({Key key, this.navigatorKey, this.tabItem}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {TabItem nextTab}) {
    var routeBuilders = _routeBuilders(context, nextTab: tabItem);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                routeBuilders[TabNavigatorRoutes.exerciseDetail](context),
        ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {TabItem nextTab}) {
    return {
      TabNavigatorRoutes.root: (context) => HomePage(
        profile: "Shardul",
      ),

      TabNavigatorRoutes.assignedExercise: (context) => AssignedExercisesPage(
        profile: "Shardul",
      ),

      TabNavigatorRoutes.exerciseHistory: (context) => ExerciseHistoryPage(
        profile: "Shardul",
      )
    };
  }

  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name](context),
        );
      },
    );
  }
}