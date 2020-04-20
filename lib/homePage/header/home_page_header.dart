import 'package:fitnesstracker/ProfilePage/profile_page.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:flutter/material.dart';
import '../../decorations.dart';

class HomePageHeader<T extends Profile> extends StatelessWidget {
  final T user;
  final dynamic today;

  static final now = DateTime.now();
  static final noon = DateTime(now.year, now.month, now.day, 12, 00, 00);
  static final evening = DateTime(now.year, now.month, now.day, 4, 00, 00);
  static final night = DateTime(now.year, now.month, now.day, 10, 00, 00);

  HomePageHeader(this.user, this.today);

  Widget _buildAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _navigateToProfilePage(context),
        child: new CircleAvatar(
          backgroundImage: new NetworkImage("https://19yw4b240vb03ws8qm25h366-wpengine.netdna-ssl.com/wp-content/uploads/Profile-Pic-Circle-Grey-Large.png"),
          radius: 80.0,
        ),
      ),
    );
  }

  _navigateToProfilePage(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ProfilePage<T>(user: user, isAlternateView: false,)
      )
    );
  }

  Widget _buildWelcomeMessage(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30,),
          child: Text(
            "Hi ${user.firstName},",
            style: Decorations.headline,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            _getSubtitle(),
            style: Decorations.subtitle,
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  String _getSubtitle() {
    switch(T) {
      case Client:
        return _getTodayExerciseStats();
      case Trainer:
        return _getTrainerDay();
      default:
        throw new Exception("Looks like you haven't logged in");
    }
  }

  String _getTrainerDay() {
    List<Client> trainerDay = today;

    if (trainerDay == null) {
      return "";
    }

    // personalisation tricks
    // assumes that past clients from that day are removed
    if (trainerDay.isEmpty) {
      return "Looks like you have no clients";
    } else if (now.isBefore(noon)) {
      return "Good Morning ${user.firstName}, looks like you have, "
          "${trainerDay.length} clients to go";
    } else if (now.isBefore(evening)) {
      return "Good Afternoon ${user.firstName}, looks like you have, "
          "${trainerDay.length} clients to go";
    } else if (now.isBefore(night)) {
      return "Good Evening ${user.firstName}, looks like you have, "
          "${trainerDay.length} clients to go";
    } else {
      return "Good Day ${user.firstName}, looks like you have, "
          "${trainerDay.length} clients to go";
    }
  }

  String _getTodayExerciseStats() {
    List<Exercise> clientDay = today;

    if (clientDay == null) {
      return "";
    }

    int completedExercises = 0;
    // compute completed exercises
    clientDay.forEach((Exercise e) => completedExercises += (e.completed == 1) ? 1 : 0);
    if (clientDay.isEmpty) {
      return "You've have no assigned exercies left";
    } else if (now.isBefore(noon)) {
      return "Good Morning ${user.firstName}, You've completed "
          "$completedExercises of ${clientDay.length} exercises today";
    } else if (now.isBefore(evening)) {
      return "Good Afternoon ${user.firstName}, You've completed "
          "$completedExercises of ${clientDay.length} exercises today";
    } else if (now.isBefore(night)) {
      return "Good Evening ${user.firstName}, You've completed "
          "$completedExercises of ${clientDay.length} exercises today";
    } else {
      return "Good Day ${user.firstName}, You've completed "
          "$completedExercises of ${clientDay.length} exercises today";
    }
  }

  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 260,
      ),
      decoration: BoxDecoration(
        gradient: Decorations.backgroundGradient,
      ),
      child: Stack(
        children: <Widget>[
          new Align(
            alignment: FractionalOffset.bottomCenter,
            child: new Column(
              children: <Widget>[
                _buildAvatar(context),
                _buildWelcomeMessage(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}