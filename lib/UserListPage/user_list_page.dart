import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/exerciseDetailPage/exercise_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../decorations.dart';

class UserListPage<T extends Profile> extends StatefulWidget {
  final T user;

  @override
  _UserListPageState createState() => _UserListPageState();
  UserListPage({Key key, this.user}) : super (key: key);
}

class _UserListPageState extends State<UserListPage> {
  dynamic _list = {};

  @override
  void initState() {
    super.initState();
    _loadList();
  }

  void _loadList() {
    //TODO: Implement API Access to get client list
  }

  Widget _buildExercises(BuildContext context, int index) {
    var exercise = _list.values;

    return new Card(
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.33,
        actions: <Widget>[
          IconSlideAction(
          caption: exercise.elementAt(index)
              ? "Mark as Incomplete" : "Mark as Complete",
            color: exercise.elementAt(index)
                ? Colors.red : Colors.green,
            icon: exercise.elementAt(index)
                ? Icons.not_interested : Icons.check,
            onTap: () => _exercisesToggled(
                exercise.elementAt(index), index
            ),
          )
        ],
        child: ListTile(
          onTap: () => _navigateToExerciseDetails(_list.keys.elementAt(index)),
          title: Text(_list.keys.elementAt(index)),
          subtitle: Text("duration"),
        ),
      ),
    );
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

  _exercisesToggled(bool value, int index) {
    // To-do: Implement API to use the exercises classes so that whenever
    // the exercise is marked complete, it's actually marked complete
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

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_list.isEmpty) {
      content = new Center(
        child: Text("Looks like you have no assigned exercises today"),
      );
    } else {
      content = ListView.builder(
        itemCount: _list.length,
        itemBuilder: _buildExercises,
      );
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
}
