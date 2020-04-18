import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Decorations {
  // colors
  static var accentColour = Color(0xFFFA716F);

  // text styles
  static var headline = TextStyle(
    fontFamily: "Raleway",
    fontWeight: FontWeight.w900,
    fontSize: 20,
    color: Colors.white.withOpacity(1.0),
  );

  static var subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: "Raleway",
    color: Colors.white.withOpacity(1.0),
  );

  static var profileUserName = TextStyle(
    fontSize: 20,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );

  static var loginRegButton = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w900,
    fontFamily: "Raleway",
    color: Colors.white.withOpacity(1.0),
  );

  static var radioButtonLabel = TextStyle(
    fontSize: 16,
    fontFamily: 'Raleway',
    color: Colors.black,
  );

  static var snackBar = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 15,
  );

  static var welcomeBack = TextStyle(
    fontSize: 30,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w900,
    color: Colors.black87,
  );

  static var logIn = TextStyle(
    fontSize: 15,
    fontFamily: 'Raleway',
    fontStyle: FontStyle.italic,
    color: Colors.grey,
  );

  static var radioButton = TextStyle(
    fontSize: 16,
    fontFamily: 'Raleway',
    color: Colors.black,
  );

  // gradients
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

  // other formatting related funcitons
  static String dateToTimeConverter(DateTime toConvert) {
    DateFormat formatter = new DateFormat.jm("en_US");

    return (formatter.format(toConvert)).toString();
  }

  static InputDecoration createInputDecoration(IconData prefixIcon, String label) {
    return InputDecoration(
      prefixIcon: prefixIcon != null? Icon(prefixIcon): Icon(null),
        fillColor: Colors.white,
        filled: true,
        labelText: "$label",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Decorations.accentColour,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
    );
  }
}