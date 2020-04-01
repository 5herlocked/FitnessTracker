import 'package:flutter/material.dart';

class AssignedExercisesPage extends StatelessWidget {
  AssignedExercisesPage({Key key, this.profile}) : super (key: key);

  final String profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profile),
      ),
      body: Center(
          child: FlatButton.icon(
            onPressed: () => _buttonPressed(context),
            icon: Icon(Icons.directions_run),
            label: Text("Assigned Exercises"),
          )
      ),
    );
  }

  _buttonPressed(BuildContext context) {
    return Scaffold.of(context).
    showSnackBar(SnackBar(
        content: Text("In $profile\'s Assigned Exercises")
    )
    );
  }
}