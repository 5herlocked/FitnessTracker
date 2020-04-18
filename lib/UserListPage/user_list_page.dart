import 'package:fitnesstracker/entities/client.dart';
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

  @override
  _UserListPageState<T> createState() => _UserListPageState<T>();
  UserListPage({Key key, this.user}) : super (key: key);
}

class _UserListPageState<T extends Profile> extends State<UserListPage<T>> {
  var _list;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_list.isEmpty) {
      switch (T) {
        case Client:
          content = new Center(
            child: Text("Looks like you have no assigned exercises today"),
          );
          break;
        case Trainer:
          content = new Center(
            child: Text("Looks like you have no clients"),
          );
          break;
      }
    } else {
      switch(T) {
        case Client:
          content = ListView.builder(
            itemCount: _list.length,
            itemBuilder: _buildExercises,
          );
          break;
        case Trainer:
          content = ListView.builder(
            itemCount: _list.length,
            itemBuilder: _buildClients,
          );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Assigned Exercises"),
      ),
        body: SafeArea(
          child: Container (
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: <Widget>[
                content,
              ],
            ),
          ),
        )
    );
  }

  void _loadList() {
    //TODO: Implement API Access to get client list
    switch (T) {
      case Client:
        _list = List<Exercise>();
        break;
      case Trainer:
        _list = List<Client>();
        break;
    }
  }

  Widget _buildClients(BuildContext context, int index) {
    List<Client> clients = _list;
    return Card(
      child: ListTile(
        onTap: () => _navigateToClient(clients.elementAt(index)),
        title: Text(clients.elementAt(index).fullName),
      ),
    );
  }

  Widget _buildExercises(BuildContext context, int index) {
    List<Exercise> exercise = _list;

    return new Card(
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.33,
        actions: <Widget>[
          IconSlideAction(
          caption: exercise.elementAt(index).completed
              ? "Mark as Incomplete" : "Mark as Complete",
            color: exercise.elementAt(index).completed
                ? Colors.red : Colors.green,
            icon: exercise.elementAt(index).completed
                ? Icons.not_interested : Icons.check,
            onTap: () => _exercisesToggled(
                exercise.elementAt(index).completed, index
            ),
          )
        ],
        child: ListTile(
          onTap: () => _navigateToExerciseDetails(_list.elementAt(index).name),
          title: Text(_list.elementAt(index)),
          subtitle: Text("duration"),
        ),
      ),
    );
  }

  void _navigateToClient(Client focusedClient) {
    // TODO: verify this works
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (c) {
          return new App<Client>(user: focusedClient, trainerView: true,);
        },
      )
    );
  }

  void _navigateToExerciseDetails(String exercise) {
    // TODO: change this to actually take us to the correct exercise details
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new ExerciseDetailPage(exercise: exercise);
        },
      ),
    );
  }

  _exercisesToggled(bool value, int index) {
    /*
    TODO: Implement API to use the exercises classes so that whenever
     the exercise is marked complete, it's actually marked complete
    */
    setState(
            () => _list.update(
            _list.keys.elementAt(index),
                (bool value) => !value)
    );
    switch(value){
      case false:
      // API call
        return Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("${_list.keys.elementAt(index)} completed",
                  style: Decorations.snackBar
              )
            ),
        );
        break;
      case true:
        return Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("${_list.keys.elementAt(index)} not complete",
                  style: Decorations.snackBar
              ),
            )
        );
        break;
    }
  }
}
