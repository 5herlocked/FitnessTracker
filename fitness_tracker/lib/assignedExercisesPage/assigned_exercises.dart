import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:flutter/material.dart';

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
      child: ListTile(
        title: Text(_assignedExercises.keys.elementAt(index)),
        subtitle: Text("duration"),
      ),
    );
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
