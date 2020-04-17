import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomOutlineButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      highlightedBorderColor: Colors.white,
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      highlightElevation: 0.0,
      splashColor: Colors.white,
      highlightColor: Color(0xFFFEA969),
      color: Color(0xFFFEA969),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Raleway', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
      ),
      onPressed: onPressed,
    );
  }

}