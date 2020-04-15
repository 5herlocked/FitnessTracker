import 'package:flutter/material.dart';

enum TabItem { today, exercises, history, profile }

class Destination {
  const Destination (this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> allDestinationsList = <Destination> [
  Destination('Home', Icons.home),
  Destination('Assigned Exercises', Icons.directions_run),
  Destination('Previous Exercises', Icons.today),
  Destination('Profile', Icons.account_circle)
];