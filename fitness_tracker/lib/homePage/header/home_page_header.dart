import 'package:fitnesstracker/profilePage/profile.dart';
import 'package:flutter/material.dart';

class HomePageHeader extends StatelessWidget {
  final LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Color.fromARGB(86, 250, 90, 90),
      Color.fromARGB(55, 255, 146, 62)
    ],
    begin: Alignment.center,
    end: Alignment.center,
  );

  final Profile profile;

  HomePageHeader(@required this.profile);

  Widget _buildAvatar() {
    return new Hero(
      tag: profile.id,
      child: new CircleAvatar(
        backgroundImage: new NetworkImage("https://picsum.photos/id/237/200/300"),
        radius: 54.0,
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Column(
      children: <Widget>[
        Text("Hi ${profile.firstName},"),
        Text("You've completed 1 of 3 exercies today. Keep at it!"),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Stack(
        children: <Widget>[
          _buildAvatar(),
          _buildWelcomeMessage(),
        ],
      ),
      alignment: Alignment.center,
    );
  }
}