import 'package:fitnesstracker/clientProfilePage/clientProfilePage.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:flutter/material.dart';
import '../../decorations.dart';

class HomePageHeader extends StatelessWidget {
  final Client client;
  final List exercisesState;

  HomePageHeader(this.client, this.exercisesState);

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

  _navigateToProfilePage(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) => ClientProfilePage(client: client,)
      )
  );

  Widget _buildWelcomeMessage(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30,),
          child: Text(
            "Hi ${client.firstName},",
            style: Decorations.headline,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            "You've completed ${exercisesState[0]} of ${exercisesState[1]} exercies today. Keep at it!",
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