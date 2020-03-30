import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.profile}) : super (key: key);

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
            icon: Icon(Icons.home),
            label: Text("Home Page"),
          )
      ),
    );
  }

  _buttonPressed(BuildContext context) {
    return Scaffold.of(context).
    showSnackBar(SnackBar(
        content: Text("In $profile\'s Home Page")
    )
    );
  }
}