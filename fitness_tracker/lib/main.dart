import 'package:fitnesstracker/app.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepOrangeAccent[800],
        accentColor: Colors.amber[1200],

        fontFamily: "Roboto",

        textTheme: TextTheme(
          headline: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: Colors.white.withOpacity(0.87),
          ),
          subtitle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "Roboto",
            color: Colors.white.withOpacity(0.87),
          ),
        )
      ),
      home: App(),
    );
  }
}