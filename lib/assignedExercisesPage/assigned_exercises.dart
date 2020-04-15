import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/exerciseDetailPage/exercise_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../decorations.dart';

class AssignedExercisesPage extends StatefulWidget {
  final ClientProfile profile;

  @override
  _AssignedExercisesPageState createState() => _AssignedExercisesPageState();
  AssignedExercisesPage({Key key, this.profile}) : super (key: key);
}

class _AssignedExercisesPageState extends State<AssignedExercisesPage> {
  Map<String, bool> _assignedExercises = {};

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  void _loadExercises() {
    //To-Do: Implement API Access
    _assignedExercises = {"Elliptical": false, "Chest Press": true, "Rowing": true,
      "Speed Walking": false, "Running": false, "Overhead Press": false, "Pole Vaulting": true};
  }

  Widget _buildExercises(BuildContext context, int index) {
    var exercise = _assignedExercises.values;

    return new Card(
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.33,
        actions: <Widget>[
          IconSlideAction(
          caption: _assignedExercises.values.elementAt(index)
              ? "Mark as Incomplete" : "Mark as Complete",
            color: _assignedExercises.values.elementAt(index)
                ? Colors.red : Colors.green,
            icon: _assignedExercises.values.elementAt(index)
                ? Icons.not_interested : Icons.check,
            onTap: () => _exercisesToggled(
                _assignedExercises.values.elementAt(index), index
            ),
          )
        ],
        child: ListTile(
          onTap: () => _navigateToExerciseDetails(_assignedExercises.keys.elementAt(index)),
          title: Text(_assignedExercises.keys.elementAt(index)),
          subtitle: Text("duration"),
        ),
      ),
    );
  }

  void _navigateToExerciseDetails(String exercise) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new ExerciseDetailPage(exercise: exercise);
        },
      ),
    );
  }

  _exercisesToggled(bool value, int index) {
    // To-do: Implement API to use the exercises classes so that whenever
    // the exercise is marked complete, it's actually marked complete
    setState(
            () => _assignedExercises.update(
            _assignedExercises.keys.elementAt(index),
                (bool value) => !value)
    );
    switch(value){
      case false:
      // API call
        return Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("${_assignedExercises.keys.elementAt(index)} completed"),
            )
        );
        break;
      case true:
        return Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("${_assignedExercises.keys.elementAt(index)} not complete"),
            )
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_assignedExercises.isEmpty) {
      content = new Center(
        child: Text("Looks like you have no assigned exercises today"),
      );
    } else {
      content = ListView.builder(
        itemCount: _assignedExercises.length,
        itemBuilder: _buildExercises,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Assigned Exercises",
          style: Decorations.headline,
        ),
        backgroundColor: Decorations.accentColour,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            content,
          ],
        ),
      ),
    );
  }
}
