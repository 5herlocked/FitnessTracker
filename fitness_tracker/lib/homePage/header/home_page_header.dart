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
    return new CircleAvatar(
      backgroundImage: new NetworkImage("https://picsum.photos/id/237/200/300"),
      radius: 90.0,
    );
  }

  Widget _buildWelcomeMessage() {
    TextStyle welcomeStyle = TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: Colors.white.withOpacity(0.87),
    );
    
    TextStyle subHeadingStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: "Roboto",
      color: Colors.white.withOpacity(0.87),
    );
    return Column(
      children: <Widget>[
        Text("Hi ${profile.firstName},", style: welcomeStyle,),
        Text("You've completed 1 of 3 exercies today. Keep at it!", style: subHeadingStyle,),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Container(
      constraints: BoxConstraints(
        maxHeight: 250,
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
                _buildWelcomeMessage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}