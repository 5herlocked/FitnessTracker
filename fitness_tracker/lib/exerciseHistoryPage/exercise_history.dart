import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:flutter/material.dart';

class ExerciseHistoryPage extends StatelessWidget {
  ExerciseHistoryPage({Key key, this.profile}) : super (key: key);

  final ClientProfile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profile.firstName),
      ),
      body: Center(
        child: FlatButton.icon(
            onPressed: () => _buttonPressed(context),
            icon: Icon(Icons.today),
            label: Text("Exercise History"),
        )
      ),
    );
  }

  _buttonPressed(BuildContext context) {
    return Scaffold.of(context).
    showSnackBar(SnackBar(
        content: Text("In $profile\'s Exercise History")
    )
    );
  }
}