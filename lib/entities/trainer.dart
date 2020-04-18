import 'dart:convert';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:http/http.dart' as http;

import 'client.dart';

class Trainer extends Profile {
  // account
  String firstName, lastName, fullName, phoneNumber, email, password;
  int trainerMembershipID;
  int trainerID;
  //profile
  String description, birthday, weight, height, fitnessGoal;

  Trainer(
      {
        this.firstName,
        this.lastName,
        this.fullName,
        this.email,
        this.trainerID,
        this.trainerMembershipID,
        this.phoneNumber,
        this.password,
        this.description,
        this.birthday,
        this.weight,
        this.height,
        this.fitnessGoal,
      }
  );

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        trainerID: json['trainer_id']);
  }

  // Send a POST request to the API to create a new client
  Future<int> createTrainerAccount() async {
    Map data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'tr_password': password,
      'phone_number': phoneNumber,
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/register',
        body: data);

    return response.statusCode;
  }

  // Send a POST request to the API to log the client in
  Future<Trainer> loginTrainer() async {
    Map data = {
      'email': email,
      'tr_password': password,
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/client/login',
        body: data);

    return Trainer.fromJson(json.decode(response.body));
  }

  // Send a POST request to the API to log the client in
  Future<Trainer> updateTrainerProfile() async {
    Map data = {
      'description': description,
      'birthday': birthday,
      'weight': weight,
      'height': height,
      'fitnessGoal': fitnessGoal
    };

    final http.Response response = await http.put(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/updateprofile',
        body: data);

    //return response.statusCode;
    return Trainer.fromJson(json.decode(response.body));
  }

  // request to API to get the list of clients for a particular trainer id
  Future<List<Client>> getClientList() async {
    //TODO verify this works as expected
    List<Client> clientList;

    final http.Response response = await http.put(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/getClientList?'
            'trainer_id=$trainerID');
    clientList = jsonDecode(response.toString())[clientList];
    return clientList;
  }
}
