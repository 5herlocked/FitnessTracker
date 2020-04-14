import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatelessWidget {
  ExerciseDetailPage({Key key, this.exercise}) : super (key: key);

  final String exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Details"),
      ),
      body: Center(
          child: FlatButton.icon(
            onPressed: () => _buttonPressed(context),
            icon: Icon(Icons.details),
            label: Text("$exercise"),
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