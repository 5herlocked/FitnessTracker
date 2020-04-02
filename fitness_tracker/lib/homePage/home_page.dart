import 'package:fitnesstracker/exerciseDetailPage/exercise_detail.dart';
import 'package:fitnesstracker/homePage/header/home_page_header.dart';
import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:flutter/material.dart';
import '../app.dart';

class HomePage extends StatefulWidget {
  final ClientProfile profile;
  @override
  _HomePageState createState() => _HomePageState();
  HomePage ({Key key, this.profile}) : super(key: key);
}

class _HomePageState extends State<HomePage> {
  List<String> _todayExercises = [];

  @override
  void initState() {
    super.initState();
    _loadTodayExercises();
  }

  void _loadTodayExercises() {
    //TO-DO: Implement API Access
    _todayExercises = ["Elliptical", "Chest Press", "Rowing"];
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_todayExercises.isEmpty) {
      content = new Center(
        child: Text("Looks like you have no Assigned Exercises Today"),
      );
    } else {
      content = ListView.builder(
          itemCount: _todayExercises.length,
          itemBuilder: _buildTodayExerciseList,
          padding: EdgeInsets.all(30),
      );
    }
    return SafeArea(
        child: Stack(
          children: <Widget>[
            HomePageHeader(widget.profile),
            new Padding(
              padding: const EdgeInsets.only(top: 250),
              child: content,
            ),
          ],
        )
    );
  }

  Widget _buildTodayExerciseList (BuildContext context, int index) {
    var exercise = _todayExercises[index];

    return new ListTile(
      onTap: () => _navigateToExerciseDetails(exercise, index),
      title: new Text(exercise),
      subtitle: new Text("duration"),
    );
  }

  void _navigateToExerciseDetails(String exercise, int index) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new ExerciseDetailPage(exercise: exercise);
        },
      ),
    );
  }
}