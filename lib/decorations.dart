import 'package:flutter/material.dart';

class Decorations {
  static var headline = TextStyle(
    fontFamily: "Raleway",
    fontWeight: FontWeight.w900,
    fontSize: 20,
    color: Colors.white.withOpacity(0.87),
  );

  static var subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: "Raleway",
    color: Colors.white.withOpacity(0.87),
  );

  static var snackBar = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 15,
  );

  static var backgroundGradient = LinearGradient(
      colors: [
        Color(0xFFFA716F),
        Color(0xFFFEA969)
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.25,
        0.75,
      ]
  );

  static var accentColour = Color.fromARGB(200, 250, 90, 90);
}