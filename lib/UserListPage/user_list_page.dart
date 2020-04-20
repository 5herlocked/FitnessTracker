import 'package:fitnesstracker/addClientPage/add_client_page.dart';
import 'package:fitnesstracker/assignExercisePage/assign_exercise_page.dart';
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
    _loadList();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (T) {
      case Client:
        pageTitle = "Assigned Exercises";
        content = _buildClientPage(_list.isEmpty);
        break;
      case Trainer:
        pageTitle = "Client List";
        content = _buildTrainerPage(_list.isEmpty);
        break;
    }

    return content;
  }

  void _loadList() {
    //TODO: Implement API Access to get client list
    switch (T) {
      case Client:
        _list = List<Exercise>();
        break;
      case Trainer:
        Trainer currentTrainer = widget.user as Trainer;
        _list = currentTrainer.listOfClients;
        break;
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

    return new Card(
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.33,
        actions: <Widget>[
          IconSlideAction(
            caption: exercise.elementAt(index).completed == 1
                ? "Mark as Incomplete"
                : "Mark as Complete",
            color:
                exercise.elementAt(index).completed == 1 ? Colors.red : Colors.green,
            icon: exercise.elementAt(index).completed == 1
                ? Icons.not_interested
                : Icons.check,
            onTap: () =>
                _exercisesToggled(exercise.elementAt(index).completed == 1, index),
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
    Navigator.of(context).push(MaterialPageRoute(
      builder: (c) {
        return new App<Client>(
          user: focusedClient,
          trainerView: true,
        );
      },
    ));
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
    setState(() =>
        _list.update(_list.keys.elementAt(index), (bool value) => !value));
    switch (value) {
      case false:
        // API call
        return Scaffold.of(context).showSnackBar(
          SnackBar(
              content: Text("${_list.keys.elementAt(index)} completed",
                  style: Decorations.snackBar)),
        );
        break;
      case true:
        return Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("${_list.keys.elementAt(index)} not complete",
              style: Decorations.snackBar),
        ));
        break;
    }
  }

  Widget _buildClientPage(bool isExerciseListEmpty) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: !isExerciseListEmpty
              ? Stack(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: _buildExercises,
                    ),
                  ],
                )
              : Center(
                  child:
                      Text("Looks like you have no assigned exercises today")),
        ),
        floatingActionButton: new Visibility(
          visible: true,
          //visible: widget.trainerView,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssignExercisePage()));
            },
            child: Icon(Icons.add),
            backgroundColor: Decorations.accentColour,
          ),
        ));
  }

  Widget _buildTrainerPage(bool isClientListEmpty) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SafeArea(
          child: !isClientListEmpty
              ? Stack(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: _list.length,
                      itemBuilder: _buildClients,
                    ),
                  ],
                )
              : Center(child: Text("Looks like you have no clients"))),
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
}
