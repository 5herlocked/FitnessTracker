// internal imports
import 'package:fitnesstracker/app.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/exerciseDetailPage/exercise_detail.dart';
import 'package:fitnesstracker/homePage/header/home_page_header.dart';
import 'package:fitnesstracker/decorations.dart';
// library imports
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage<T extends Profile> extends StatefulWidget {
  final Profile user;
  @override
  _HomePageState<T> createState() => _HomePageState<T>();
  HomePage ({Key key, this.user}) : super(key: key);
}

class _HomePageState<T extends Profile> extends State<HomePage<T>> {
  dynamic _today;

  @override
  void initState() {
    super.initState();
    _loadToday();
  }

  void _loadToday() {
    //TODO: Implement API Access
    switch(widget.user.runtimeType) {
      case Client:
        _today = List<Exercise>();
        break;
      case Trainer:
        _today = Map<Client, DateTime>();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_today.isEmpty) {
      content = new Center(
        child: Text("Looks like you have no Assigned Exercises Today"),
      );
    } else {
      content = ListView.builder(
          itemCount: _today.length,
          itemBuilder: _buildToday,
      );
    }
    return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              HomePageHeader(widget.user, _today),
              new Padding(
                padding: const EdgeInsets.only(top: 260),
                child: content,
              ),
            ],
          )
      )
    );
  }

  Widget _buildToday (BuildContext context, int index) {
    switch(widget.user.runtimeType) {
      case Client:
        return _buildClientToday(context, index);
      case Trainer:
        return _buildTrainerToday(context, index);
      default:
        throw new Exception("Not Logged in");
        break;
    }
  }

  Widget _buildClientToday(BuildContext context, int index) {
    List<Exercise> clientDay = _today;

    Exercise currentElement = clientDay.elementAt(index);

    return Card(
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.33,
        child: ListTile(
          onTap: () async => _navigateToExerciseDetails(clientDay.elementAt(index).name),
          title: Text(clientDay.elementAt(index).name),
          subtitle: Text("duration"),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: currentElement.completed
                ? "Mark as Incomplete" : "Mark as complete",
            color: currentElement.completed
                ? Colors.red : Colors.green,
            icon: currentElement.completed
                ? Icons.not_interested : Icons.check,
            onTap: () => _exercisesToggled(clientDay, index),
          )
        ],
      ),
    );
  }

  Widget _buildTrainerToday(BuildContext context, int index) {
    Map<Client, DateTime> trainerDay = _today;

    Client currentClient = trainerDay.keys.elementAt(index);
    DateTime currentClientSchedule = trainerDay.values.elementAt(index);

    return Card(
      child: ListTile(
        onTap: () async => _navigateToClientProfile(currentClient),
        title: Text(currentClient.fullName),
        subtitle: Text(Decorations.dateToTimeConverter(currentClientSchedule)),
      ),
    );
  }

  _navigateToClientProfile(Client client) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          // TODO lazy implementation, this cannot make it into prod
          return new App(client: client,);
        }
      )
    );
  }

  _exercisesToggled(List<Exercise> exerciseList, int index) {
    // TODO: Implement API to use the exercises classes so that whenever
    // the exercise is marked complete, it's actually marked complete
    setState(
            () => exerciseList.elementAt(index).completed =
            !exerciseList.elementAt(index).completed
    );
    switch(exerciseList.elementAt(index).completed){
      case false:
        // API call
        return Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("${exerciseList.elementAt(index)} completed"),
          )
        );
        break;
      case true:
        return Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("${exerciseList.elementAt(index)} not complete"),
          )
        );
        break;
    }
  }

  void _navigateToExerciseDetails(String exercise) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new ExerciseDetailPage(exercise: exercise);
        },
      ),
    );
  }
}