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

  // Send a POST request to the API to assign an exercise to the client
  Future<int> assignStrengthExercise() async {
    Map data = {
      'client_id' : clientID, //int
      'trainer_id': trainerID, //int
      'notes': notes, //String
      'reps': reps, //int
      'sets': sets, //int
      'weight': weight, //double
      'name': name //String
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/assign-strength-exercise',
        body: data);

    return response.statusCode;
    //return CardioExercise.fromJson(json.decode(response.body));
  }
}