import 'package:flutter/material.dart';

enum TabItem { today, exercises, history, profile }

class Destination {
  const Destination (this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> clientDestinationsList = <Destination> [
  Destination('Home', Icons.home),
  Destination('Assigned Exercises', Icons.directions_run),
  Destination('Previous Exercises', Icons.today),
  Destination('Profile', Icons.account_circle)
];

const List<Destination> trainerDestinationsList = <Destination> [
  Destination('Home', Icons.home),
  Destination('Client List', Icons.people),
  Destination('Profile', Icons.account_circle),
];