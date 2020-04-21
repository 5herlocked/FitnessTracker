import 'package:fitnesstracker/entities/exercise.dart';
import 'package:http/http.dart' as http;

class StrengthTrainingExercise extends Exercise {
  int weight;
  int reps;
  int sets;
  StrengthTrainingExercise(
      {
        clientID,
        this.weight,
        this.reps,
        this.sets,
        trainerID,
        name,
        notes,
        completed
      }
      ) : super (
      clientID: clientID,
      trainerID: trainerID,
      name: name,
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
      name: json["name"],
      notes: json["notes"],
      completed: json["completed"],
    );
  }

  // Send a POST request to the API to assign a strength training exercise to the client
  Future<int> assignStrengthExercise() async {
    String url = 'https://mad-fitnesstracker.herokuapp.com/api/trainer/assignStrengthExercise?'
        'client_id=$clientID&trainer_id=$trainerID&notes=$notes&name=$name&reps=$reps&sets=$sets&weight=$weight';

    final http.Response response = await http.post(url);

    return response.statusCode;
  }
}