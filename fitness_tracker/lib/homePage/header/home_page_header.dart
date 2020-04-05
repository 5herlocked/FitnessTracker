import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:flutter/material.dart';

class HomePageHeader extends StatelessWidget {
  final LinearGradient backgroundGradient = LinearGradient(
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

  final ClientProfile profile;

  HomePageHeader(this.profile);

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new CircleAvatar(
        backgroundImage: new NetworkImage("https://picsum.photos/id/237/200/300"),
        radius: 90.0,
      ),
    );
  }

  Widget _buildWelcomeMessage(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30,),
          child: Text(
            "Hi ${profile.firstName},",
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            "You've completed 1 of 3 exercies today. Keep at it!",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 275,
      ),
      decoration: BoxDecoration(
        gradient: backgroundGradient
      ),
      child: Stack(
        children: <Widget>[
          new Align(
            alignment: FractionalOffset.bottomCenter,
            child: new Column(
              children: <Widget>[
                _buildAvatar(),
                _buildWelcomeMessage(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}