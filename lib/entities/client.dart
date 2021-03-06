import 'dart:convert';
import 'package:fitnesstracker/entities/cardio_exercise.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/strength_training_exercise.dart';
import 'package:http/http.dart' as http;

class Client extends Profile {
  // account
  String fullName;
  bool isTrainerAssigned = false;
  int clientID;
  int trainerID; // ID of the trainer assigned to the client
  List<Exercise> assignedExercises;

  Client(
      {
        firstName,
        lastName,
        this.fullName,
        this.assignedExercises,
        email,
        this.clientID,
        this.trainerID,
        phoneNumber,
        password,
        profileAttributes,
        profilePicture
      }
      ) : super(
    firstName: firstName,
    lastName: lastName,
    emailID: email,
    phoneNumber: phoneNumber,
    password: password,
    profilePicture: "https://www.getfeedback.com/static/ce27cad29ac6702ad0e32ecb0c49999a/c85f0/hero-happy.jpg",
    profileAttributes: profileAttributes,
  );

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      clientID: json['client_id'],
      trainerID: json['trainer_id'],
      profileAttributes: json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null,
    );
  }

  // Send a POST request to the API to create a new client
  Future<Client> createClientAccount() async {
    Map data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': emailID,
      'cl_password': password,
      'phone_number': phoneNumber,
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/client/register',
        body: data);

    return Client.fromJson(json.decode(response.body));
  }

  // Send a POST request to the API to log the client in
  Future<Client> loginClient() async {
    Map data = {
      'email': emailID,
      'cl_password': password,
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/client/login',
        body: data);

    return Client.fromJson(json.decode(response.body));
  }

  // Send a POST request to the API to log the client in
  Future<int> updateClientProfile() async {
    String url = "";
    if(this.profileAttributes.birthday == null) {
      url = "https://mad-fitnesstracker.herokuapp.com/api/client/updateProfile?"
          "client_id=$clientID&bio=${profileAttributes.description}&current_email=$emailID"
          "&height=${profileAttributes.height}&weight=${profileAttributes.weight}&goal=${profileAttributes.fitnessGoal}";
    }else {
      url = "https://mad-fitnesstracker.herokuapp.com/api/client/updateProfile?"
          "client_id=$clientID&bio=${profileAttributes.description}&current_email=$emailID"
          "&height=${profileAttributes.height}&weight=${profileAttributes.weight}&goal=${profileAttributes.fitnessGoal}&dob=${profileAttributes.birthday}";
    }

    final http.Response response = await http.post(url);

    return response.statusCode;
    //return Client.fromJson(json.decode(response.body));
  }

  // Send a POST request to the API to log the client in
  Future<Client> getClientProfile() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/client/getProfile?client_id=' +
            "$clientID");

    //return response.statusCode;
    return Client.fromJson(json.decode(response.body));
  }

  Future<List<Exercise>> getAssignedExercises() async {
    List<Exercise> assignedExercises = new List<Exercise>();
    List<CardioExercise> cardioList = await getCardioExercises();
    List<StrengthTrainingExercise> strengthList = await getStrengthExercises();

    assignedExercises.addAll(cardioList);
    assignedExercises.addAll(strengthList);
    this.assignedExercises = assignedExercises;
    return assignedExercises;
  }

  // Send a POST request to the API to log the client in
  Future<List<CardioExercise>> getCardioExercises() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/client/getAssignedCardioExercises?client_id=$clientID');

    // 1. Create a List of Users
    final List<CardioExercise> fetchedCardioList = [];

    // 2. Decode the response body
    List<dynamic> responseData = jsonDecode(response.body);

    // 3. Iterate through all the users in the list
    responseData?.forEach((dynamic userData) {
      // 4. Create a new user and add to the list
      final CardioExercise cardioExercise = CardioExercise.fromJson(userData);
      fetchedCardioList.add(cardioExercise);
    });

    // 5. Update our list and the UI
    return fetchedCardioList;
  }

  // Send a POST request to the API to log the client in
  Future<List<StrengthTrainingExercise>> getStrengthExercises() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/client/getAssignedStrengthExercises?client_id=$clientID');

    // 1. Create a List of Users
    final List<StrengthTrainingExercise> fetchedStrengthExercisesList = [];

    // 2. Decode the response body
    List<dynamic> responseData = jsonDecode(response.body);

    // 3. Iterate through all the users in the list
    responseData?.forEach((dynamic userData) {
      // 4. Create a new user and add to the list
      final StrengthTrainingExercise strengthTrainingExercise =
      StrengthTrainingExercise.fromJson(userData);
      fetchedStrengthExercisesList.add(strengthTrainingExercise);
    });

    // 5. Update our list and the UI
    return fetchedStrengthExercisesList;
  }
}