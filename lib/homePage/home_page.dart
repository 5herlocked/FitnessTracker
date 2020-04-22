import 'package:fitnesstracker/app.dart';
import 'package:fitnesstracker/entities/cardio_exercise.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/strength_training_exercise.dart';
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
    _loadToday().then((value) {
      setState(() {_today = value;});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_today == null) {
      // Show blank container while page loads
      content = new Container();
    } else if(_today.isEmpty) {
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
              RefreshIndicator(
                onRefresh: () => _loadToday(),
                backgroundColor: Decorations.accentColour,
                color: Colors.white,
                child: new Padding(
                  padding: const EdgeInsets.only(top: 260),
                  child: content,
                ),
              ),
            ],
          )
      )
    );
  }


  Future<List> _loadToday() async {
    switch(T) {
      case Client:
        Client currentClient = widget.user as Client;
        return await currentClient.getAssignedExercises();
      case Trainer:
        Trainer currentTrainer = widget.user as Trainer;
        return await currentTrainer.getClientList();
    }
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
        child: _buildExerciseListTile(currentElement),
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

  ListTile _buildExerciseListTile(Exercise currentElement) {
    if (currentElement is CardioExercise) {
      return ListTile(
        title: Text(currentElement.name),
        subtitle: Text("${currentElement.duration} minutes"),
        onTap: () => _navigateToExerciseDetails(currentElement),
      );
    } else if (currentElement is StrengthTrainingExercise) {
      return ListTile(
        title: Text(currentElement.name),
        subtitle: Text("${currentElement.sets} sets, ${currentElement.reps} reps, at ${currentElement.weight} pounds"),
        onTap: () => _navigateToExerciseDetails(currentElement),
      );
    } else {
      return null;
    }
  }

  Widget _buildTrainerToday(BuildContext context, int index) {
    List<Client> trainerDay = _today;
    Client currentClient = trainerDay.elementAt(index);

    return Card(
      child: ListTile(
        onTap: () => _navigateToClientProfile(currentClient),
        title: Text("${currentClient.firstName} ${currentClient.lastName}"),
      ),
    );
  }

  _navigateToClientProfile(Client client) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
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
            content: Text("${exerciseList.elementAt(index).name} completed"),
          )
        );
        break;
      case 0:
        return Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("${exerciseList.elementAt(index).name} not complete"),
          )
        );
        break;
    }
  }

  void _navigateToExerciseDetails(Exercise exercise) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new ExerciseDetailPage(exercise: exercise);
        },
      ),
    );
  }
}