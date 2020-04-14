import 'package:fitnesstracker/entities/client_profile.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/profilePage/profilePage.dart';
import 'package:flutter/material.dart';

import '../../decorations.dart';

class HomePageHeader extends StatelessWidget {
  final ClientProfile profile;
  final List exercisesState;

  HomePageHeader(this.profile, this.exercisesState);

  Widget _buildAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _navigateToProfilePage(context),
        child: new CircleAvatar(
          backgroundImage: new NetworkImage("https://picsum.photos/id/237/200/300"),
          radius: 90.0,
        ),
      ),
    );
  }

  _navigateToProfilePage(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ProfilePage(profile: profile.firstName,)
      )
  );

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
            "You've completed ${exercisesState[0]} of ${exercisesState[1]} exercies today. Keep at it!",
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