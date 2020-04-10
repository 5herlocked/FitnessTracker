import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.33,
        actions: <Widget>[
          IconSlideAction(
          caption: _assignedExercises.values.elementAt(index)
              ? "Completed" : "Not Completed",
            color: _assignedExercises.values.elementAt(index)
                ? Colors.green : Colors.red,
            icon: _assignedExercises.values.elementAt(index)
                ? Icons.check : Icons.not_interested,
            onTap: () => _exercisesToggled(
                _assignedExercises.values.elementAt(index), index
            ),
          )
        ],
        child: ListTile(
          title: Text(_assignedExercises.keys.elementAt(index)),
          subtitle: Text("duration"),
        ),
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
      case true:
      // API call
        return Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("${_assignedExercises.keys.elementAt(index)} completed"),
            )
        );
        break;
      case false:
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
        padding: EdgeInsets.all(30),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Assigned Exercises",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Colors.white.withOpacity(0.87),
          ),
        ),
        backgroundColor: Color.fromARGB(200, 250, 90, 90),
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
