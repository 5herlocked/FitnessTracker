import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:flutter/material.dart';

class ExerciseHistoryPage extends StatelessWidget {
  ExerciseHistoryPage({Key key, this.client}) : super (key: key);

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise History"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: FlatButton.icon(
              onPressed: () => _buttonPressed(context),
              icon: Icon(Icons.today),
              label: Text("Exercise History"),
          )
        ),
      )
    );
  }

  _buttonPressed(BuildContext context) {
    return Scaffold.of(context).
    showSnackBar(SnackBar(
        content: Text("In " + client.firstName + "\'s Exercise History")
    )
    );
  }
}