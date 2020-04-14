import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:flutter/material.dart';

import '../../decorations.dart';

class HomePageHeader extends StatelessWidget {
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
            style: Decorations.headline,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            "You've completed 1 of 3 exercies today. Keep at it!",
            style: Decorations.subtitle,
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
        gradient: Decorations.backgroundGradient,
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