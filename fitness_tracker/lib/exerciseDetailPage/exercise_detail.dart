import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatelessWidget {
  ExerciseDetailPage({Key key, this.exercise, this.title}) : super (key: key);

  final String exercise;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: FlatButton.icon(
            onPressed: () => _buttonPressed(context),
            icon: Icon(Icons.details),
            label: Text("Exercise Detail"),
          )
      ),
    );
  }

  _buttonPressed(BuildContext context) {
    return Scaffold.of(context).
    showSnackBar(SnackBar(
        content: Text("In $exercise Detail")
    )
    );
  }
}