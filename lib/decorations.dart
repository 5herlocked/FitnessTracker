import 'package:flutter/material.dart';

class Decorations {
  static var headline = TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: Colors.white.withOpacity(0.87),
  );

  static var subtitle = TextStyle (
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: "Roboto",
    color: Colors.white.withOpacity(0.87),
  );

  static var backgroundGradient = LinearGradient(
      colors: [
        Color.fromARGB(200, 250, 90, 90),
        Color.fromARGB(200, 255, 146, 62)
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