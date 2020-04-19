import 'package:fitnesstracker/entities/exercise.dart';
import 'package:http/http.dart' as http;

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

  // Send a POST request to the API to assign an exercise to the client
  Future<int> assignCardioExercise() async {
    Map data = {
      'client_id' : clientID, //int
      'trainer_id': trainerID, //int
      'notes': notes, //String
      'duration': duration, //int
      'distance': distance, //int
      'name': name, //String
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/assign-cardio-exercise',
        body: data);

    return response.statusCode;
    //return CardioExercise.fromJson(json.decode(response.body));
  }
}
