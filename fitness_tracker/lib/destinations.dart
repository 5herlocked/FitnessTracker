import 'package:flutter/material.dart';

enum TabItem { today, exercises, history, profile }

class Destination {
  const Destination (this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinationsList = <Destination> [
  Destination('Home', Icons.home, Colors.indigo),
  Destination('Assigned Exercises', Icons.directions_run, Colors.deepOrange),
  Destination('Previous Exercises', Icons.today, Colors.amber),
  Destination('Profile', Icons.account_circle, Colors.blue)
];

class DestinationView extends StatefulWidget {
  const DestinationView ({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: 'sample text: ${widget.destination.title}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.destination.title}'),
        backgroundColor: widget.destination.color,
      ),
      backgroundColor: widget.destination.color[100],
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: TextField(controller: _textController,),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}