import 'package:fitnesstracker/decorations.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:flutter/material.dart';

class ExerciseHistoryPage extends StatelessWidget {
  ExerciseHistoryPage({Key key, this.client}) : super (key: key);

  final Client client;
  List<Exercise> completedExercises = List<Exercise>();

  @override
  Widget build(BuildContext context) {
    _updateHistory();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercise History"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _updateHistory(),
        backgroundColor: Decorations.accentColour,
        color: Colors.white,
        child: SafeArea(
          child: _buildContent(),
        ),
      )
    );
  }

  Widget _buildContent() {
    if (client.assignedExercises == null || client.assignedExercises.isEmpty) {
      return Center (
        child: Text("Looks like you have no exercises on file"),
      );
    } else {
      return ListView.builder(
        itemCount: completedExercises.length,
        itemBuilder: _buildCompletedExercises,
      );
    }
  }

  Widget _buildCompletedExercises(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(completedExercises.elementAt(index).name),
      ),
    );
  }

   Future<List> _updateHistory() async {
     completedExercises = List<Exercise>();
     client.assignedExercises.forEach(
             (exercise) => (exercise.completed == 1) ? completedExercises.add(exercise) : null);
     return await client.getAssignedExercises();
  }
}