import 'dart:convert';
import 'package:fitnesstracker/entities/cardio_exercise.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/strength_training_exercise.dart';
import 'package:http/http.dart' as http;
class Client extends Profile {
  // account
  String fullName;
  int clientID;
  int trainerID; // ID of the trainer assigned to the client

  //profile
  String description, birthday, weight, height, fitnessGoal;

  Client({
    firstName,
    lastName,
    this.fullName,
    email,
    this.clientID,
    this.trainerID,
    phoneNumber,
    password,
    this.description,
    this.birthday,
    this.weight,
    this.height,
    this.fitnessGoal,
    profilePicture}):super(firstName: firstName, lastName: lastName, emailID: email, phoneNumber: phoneNumber, password: password, profilePicture: profilePicture);

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        clientID: json['client_id'],
        description: json['description'],
        birthday: json['birthday'],
        height: json['height'],
        weight: json['weight'],
        fitnessGoal: json['fitness_goal']
    );
  }

  // Send a POST request to the API to create a new client
  Future<int> createClientAccount() async {
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

    return response.statusCode;
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
    Map data = {
      'client_id' : clientID,
      'description': description,
      'birthday': birthday,
      'weight': weight,
      'height': height,
      'fitnessGoal': fitnessGoal
    };

    final http.Response response = await http.put(
        'https://mad-fitnesstracker.herokuapp.com/api/client/updateprofile',
        body: data);

    return response.statusCode;
    //return Client.fromJson(json.decode(response.body));
  }

  // Send a POST request to the API to log the client in
  Future<Client> getClientProfile() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/client/updateprofile' + "$clientID");

    //return response.statusCode;
    return Client.fromJson(json.decode(response.body));
  }

<<<<<<< HEAD
  Future<List<Exercise>> getAssignedExercises() async {
    // TODO verify this works
    List<Exercise> assignedExercises;
    List<CardioExercise> cardioList;
    List<StrengthTrainingExercise> strengthList;

    final http.Response cardioResponse = await http.put(
      'https://mad-fitnesstracker.herokuapp.com/api/client/getAssignedCardioExercies?'
          'client_id=$clientID');
    final http.Response strengthTrainingResponse = await http.put(
      'https://mad-fitnesstracker.herokuapp.com/api/client/getAssignedStrengthExercises?'
          'client_id=$clientID');

    cardioList = jsonDecode(cardioResponse.toString())[cardioList];
    strengthList = jsonDecode(strengthTrainingResponse.toString())[strengthList];
    assignedExercises.addAll(cardioList);
    assignedExercises.addAll(strengthList);
    return assignedExercises;
  }
=======
>>>>>>> master
}