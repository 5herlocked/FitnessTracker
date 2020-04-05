import 'package:fitnesstracker/entities/exercise.dart';

class StrengthTrainingExercise extends Exercise {
  double weight;
  int reps;
  int sets;
  StrengthTrainingExercise(
      {
        clientID,
        this.weight,
        this.reps,
        this.sets,
        trainerID,
        notes,
        completed
      }
      ) : super (
      clientID: clientID,
      trainerID: trainerID,
      notes: notes,
      completed: completed
  );

  factory StrengthTrainingExercise.fromJson(Map<String, dynamic> json) {
    return StrengthTrainingExercise(
      clientID: json["client_id"],
      weight: json["weight"],
      reps: json["reps"],
      sets: json["sets"],
      trainerID: json["trainer_id"],
      notes: json["notes"],
      completed: json["completed"],
    );
  }
}