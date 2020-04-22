import 'package:flutter/material.dart';

enum ClientTabItem { today, exercises, history, profile }
enum TrainerTabItem { today, clientList, profile }
enum ClientViewTabItem { profile, exercises, history }

class Destination {
  const Destination (this.title, this.icon, this.tabItem);
  final String title;
  final IconData icon;
  final dynamic tabItem;

  static const  List<Destination> clientDestinationsList = <Destination> [
    Destination('Home', Icons.home, ClientTabItem.today),
    Destination('Assigned Exercises', Icons.fitness_center, ClientTabItem.exercises),
    Destination('Previous Exercises', Icons.today, ClientTabItem.history),
    Destination('Profile', Icons.account_circle, ClientTabItem.profile)
  ];

  static const List<Destination> trainerDestinationsList = <Destination> [
    Destination('Home', Icons.home, TrainerTabItem.today),
    Destination('Client List', Icons.people, TrainerTabItem.clientList),
    Destination('Profile', Icons.account_circle, TrainerTabItem.profile),
  ];

  static const List<Destination> trainerClientViewDestinationList = <Destination> [
    Destination('Profile', Icons.account_circle, ClientViewTabItem.profile),
    Destination('Assigned Exercies', Icons.fitness_center, ClientViewTabItem.exercises),
    Destination('Previous Exercises', Icons.history, ClientViewTabItem.history),
  ];
}