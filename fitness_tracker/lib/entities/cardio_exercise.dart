import 'package:fitnesstracker/entities/exercise.dart';

class CardioExercise extends Exercise {
  int distance;
  int duration;
  int caloriesBurnt;
  DateTime timeStarted;
  DateTime timeEnded;

  CardioExercise({clientID, trainerID, name, this.distance, this.duration,
    this.caloriesBurnt, completed, notes, this.timeStarted, this.timeEnded})
  : super(
      clientID: clientID,
      trainerID: trainerID,
      notes: notes,
      name: name,
      completed: completed
  );

  factory CardioExercise.fromJson(Map<String, dynamic> json) {
    return CardioExercise(
      clientID: json["client_id"],
      trainerID: json["trainer_id"],
      name: json["name"],
      distance: json["distance"],
      duration: json["duration"],
      caloriesBurnt: json["calories_burnt"],
      completed: json["completed"],
      notes: json["notes"],
      timeStarted: json["time_started"],
      timeEnded: json["time_ended"]
    );
  }
}