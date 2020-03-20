import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.profileId, this.title, this.onPush}) : super (key: key);
  final String profileId;
  final String title;
  final ValueChanged<int> onPush;

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

}