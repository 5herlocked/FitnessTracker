// internal imports
import 'package:fitnesstracker/app.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/testEntities.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/exerciseDetailPage/exercise_detail.dart';
import 'package:fitnesstracker/homePage/header/home_page_header.dart';
import 'package:fitnesstracker/decorations.dart';
// library imports
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage<T extends Profile> extends StatefulWidget {
  final T user;
  @override
  _HomePageState<T> createState() => _HomePageState<T>();
  HomePage ({Key key, this.user}) : super(key: key);
}

class _HomePageState<T extends Profile> extends State<HomePage<T>> {
  var _today;

  @override
  void initState() {
    super.initState();
  }

  void _loadToday() async {
    switch(T) {
      case Client:
        _today = List<Exercise>();
        break;
      case Trainer:
        Trainer currentTrainer = widget.user as Trainer;
        _today = currentTrainer.listOfClients;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadToday();
    Widget content;

    _loadToday();

    if(_today == null) {
      // This is what we show while we're loading
      content = new Container();
    } else if (_today.isEmpty) {
      switch(T) {
        case Trainer:
          content = new Center(child: Text("Looks like you have no clients today"));
          break;
        case Client:
          content = new Center(child: Text("Looks like you have no assigned exercises today"));
      }
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
    switch(T) {
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
          subtitle: Text("Duration: 30 minutes"),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: currentElement.completed == 1
                ? "Mark as Incomplete" : "Mark as complete",
            color: currentElement.completed == 1
                ? Colors.red : Colors.green,
            icon: currentElement.completed == 1
                ? Icons.not_interested : Icons.check,
            onTap: () => _exercisesToggled(clientDay, index),
          )
        ],
      ),
    );
  }

  Widget _buildTrainerToday(BuildContext context, int index) {
    List<Client> trainerDay = _today;

    Client currentClient = trainerDay.elementAt(index);
    //DateTime currentClientSchedule = trainerDay.elementAt(index);

    return Card(
      child: ListTile(
        onTap: () => _navigateToClientProfile(currentClient),
        title: Text(currentClient.firstName + " " + currentClient.lastName),
        //subtitle: Text(Decorations.dateToTimeConverter(currentClientSchedule)),
      ),
    );
  }

  _navigateToClientProfile(Client client) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          // TODO lazy implementation, this cannot make it into prod
          return App<Client>(user: client, trainerView: true,);
        }
      ),
    );
  }

  _exercisesToggled(List<Exercise> exerciseList, int index) {
    // TODO: Implement API to use the exercises classes so that whenever
    // the exercise is marked complete, it's actually marked complete
    setState(
            () => exerciseList.elementAt(index).completed =
            exerciseList.elementAt(index).completed == 1? 0: 1
    );
    switch(exerciseList.elementAt(index).completed){
      case 1:
        // API call
        return Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("${exerciseList.elementAt(index)} completed"),
          )
        );
        break;
      case 0:
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