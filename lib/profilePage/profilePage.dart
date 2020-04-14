import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key, this.profile}) : super (key: key);

  final String profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Center(
          child: FlatButton.icon(
            onPressed: () => _buttonPressed(context),
            icon: Icon(Icons.details),
            label: Text("$profile"),
          )
      ),
    );
  }

  _buttonPressed(BuildContext context) {
    return Scaffold.of(context).
    showSnackBar(SnackBar(
        content: Text("In $profile")
    )
    );
  }
}