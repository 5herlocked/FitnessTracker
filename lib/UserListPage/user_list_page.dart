import 'package:fitnesstracker/addClientPage/add_client_page.dart';
import 'package:fitnesstracker/assignExercisePage/assign_exercise_page.dart';
import 'package:fitnesstracker/entities/cardio_exercise.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/strength_training_exercise.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/exerciseDetailPage/exercise_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fitnesstracker/app.dart';

import '../decorations.dart';

class UserListPage<T extends Profile> extends StatefulWidget {
  final T user;
  bool isTrainerView;

  @override
  _UserListPageState<T> createState() => _UserListPageState<T>();
  UserListPage({Key key, this.user, this.isTrainerView}) : super(key: key);
}

class _UserListPageState<T extends Profile> extends State<UserListPage<T>> {
  var _list;
  String pageTitle;

  @override
  void initState() {
    super.initState();
    _loadList().then((value) {
      setState(() {
        _list = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (T) {
      case Client:
        pageTitle = "Assigned Exercises";
        content = _buildClientPage();
        break;
      case Trainer:
        pageTitle = "Client List";
        content = _buildTrainerPage();
        break;
    }

    return content;
  }

  Future<List> _loadList() async {
    switch (T) {
      case Client:
        Client currentClient = widget.user as Client;
        return await currentClient.getAssignedExercises();
      case Trainer:
        Trainer currentTrainer = widget.user as Trainer;
        return await currentTrainer.getClientList();
    }
  }

  Widget _buildClients(BuildContext context, int index) {
    List<Client> clients = _list;
    return Card(
      child: ListTile(
        onTap: () => _navigateToClient(clients.elementAt(index)),
        title: Text(clients.elementAt(index).firstName + " " + clients.elementAt(index).lastName),
      ),
    );
  }

  Widget _buildExercises(BuildContext context, int index) {
    List<Exercise> exercise = _list;

    Exercise currentElement = exercise.elementAt(index);

    return new Card(
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.33,
        actions: <Widget>[
          IconSlideAction(
            caption: (currentElement.completed == 1)
                ? "Mark as Incomplete" : "Mark as Complete",
            color: (currentElement.completed == 1)
                ? Colors.red : Colors.green,
            icon: (currentElement.completed == 1)
                ? Icons.not_interested : Icons.check,
            onTap: () =>
                _exercisesToggled(currentElement.completed, index),
          )
        ],
        child: _buildExerciseListTile(currentElement),
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
          onTap: () => _navigateToExerciseDetails(currentElement)
      );
    } else {
      return null;
    }
  }

  void _navigateToClient(Client focusedClient) {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (c) {
            return new App<Client>(
              user: focusedClient,
              trainerView: true,
            );
          },
        )
    );
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

  _exercisesToggled(int value, int index) {
    /*
    TODO: Implement API to use the exercises classes so that whenever
     the exercise is marked complete, it's actually marked complete
    */
    setState(() =>
        _list.update(_list.elementAt(index), (int value) => (value == 1) ? 0 : 1));
    switch (value) {
      case 0:
        // API call
        return Scaffold.of(context).showSnackBar(
          SnackBar(
              content: Text("${_list.keys.elementAt(index)} completed",
                  style: Decorations.snackBar)),
        );
        break;
      case 1:
        return Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("${_list.keys.elementAt(index)} not complete",
              style: Decorations.snackBar),
        ));
        break;
    }
  }

  Widget _buildClientPage() {
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _buildClientContents(),
        ),
        floatingActionButton: new Visibility(
          visible: widget.isTrainerView,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssignExercisePage(user: widget.user)));
            },
            child: Icon(Icons.add),
            backgroundColor: Decorations.accentColour,
          ),
        ));
  }

  Widget _buildClientContents() {
    if (_list == null || _list.isEmpty) {
      return Center(
          child: Text("Looks like you have no assigned exercises today"),
      );
    } else {
      return Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: _list.length,
            itemBuilder: _buildExercises,
          ),
        ],
      );
    }
  }

  Widget _buildTrainerPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SafeArea(
          child: _buildTrainerContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddClientPage(
                        listOfClientsUnderTrainer: _list, user: widget.user,
                      )));
        },
        child: Icon(Icons.add),
        backgroundColor: Decorations.accentColour,
      ),
    );
  }

  _buildTrainerContent() {
    if (_list == null || _list.isEmpty) {
      return Center(
          child: Text("Looks like you have no Clients"),
      );
    } else {
      return Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: _list.length,
            itemBuilder: _buildClients,
          ),
        ],
      );
    }
  }
}
