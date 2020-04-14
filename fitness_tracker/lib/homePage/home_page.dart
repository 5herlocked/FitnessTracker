import 'package:fitnesstracker/exerciseDetailPage/exercise_detail.dart';
import 'package:fitnesstracker/homePage/header/home_page_header.dart';
import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:fitnesstracker/decorations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final ClientProfile profile;
  @override
  _HomePageState createState() => _HomePageState();
  HomePage ({Key key, this.profile}) : super(key: key);
}

class _HomePageState extends State<HomePage> {
  Map<String, bool> _todayExercises = {  };

  @override
  void initState() {
    super.initState();
    _loadTodayExercises();
  }

  void _loadTodayExercises() {
    //TO-DO: Implement API Access
    _todayExercises = {"Elliptical": false, "Chest Press": true, "Rowing": true,
      "Speed Walking": false, "Running": false, "Overhead Press": false, "Pole Vaulting": true};
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
          padding: EdgeInsets.only(right: 30, left: 30),
      );
    }
    return SafeArea(
        child: Stack(
          children: <Widget>[
            HomePageHeader(widget.profile),
            new Padding(
              padding: const EdgeInsets.only(top: 275),
              child: content,
            ),
          ],
        )
    );
  }

  Widget _buildTodayExerciseList (BuildContext context, int index) {
    var exercises = _todayExercises.keys;
    return new Card(
      child: CheckboxListTile(
        title: Text(exercises.elementAt(index)),
        subtitle: Text("duration"),
        value: _todayExercises.values.elementAt(index), // to be changed when exercise class is completed
        checkColor: Colors.white,
        activeColor: Decorations.accentColour,
        onChanged: (bool value) => _exercisesToggled(value, index),
      ),
    );
  }

  _exercisesToggled(bool value, int index) {
    // To-do: Implement API to use the exercises classes so that whenever
    // the exercise is marked complete, it's actually marked complete
    setState(
            () => _todayExercises.update(
                _todayExercises.keys.elementAt(index),
                    (bool value) => !value)
    );
    switch(value){
      case true:
        // API call
        return Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("${_todayExercises.keys.elementAt(index)} completed"),
          )
        );
        break;
      case false:
        return Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("${_todayExercises.keys.elementAt(index)} not complete"),
          )
        );
        break;
    }
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