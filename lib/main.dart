import 'package:fitnesstracker/app.dart';
import 'package:flutter/material.dart';
import 'loginRegistrationPage/loginRegisterPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
          brightness: Brightness.light,
          hintColor: Color(0xFFc6c6c6),
          primaryColor: Color(0xFFFA716F),
          canvasColor: Colors.transparent,
          fontFamily: "Raleway",
      ),
      home: LoginRegister(),
      routes: <String, WidgetBuilder>{
        '/app': (BuildContext context) => new App(),
        '/login': (BuildContext context) => new LoginRegister(),
      },
    );
  }
}