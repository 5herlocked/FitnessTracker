import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String text;
  final Color splashColor, highlightColor, fillColor, textColor;
  final VoidCallback onPressed;

  CustomFilledButton({this.text, this.splashColor, this.highlightColor, this.textColor, this.fillColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Raleway', color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed
    );
  }

}