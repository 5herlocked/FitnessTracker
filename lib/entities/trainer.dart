import 'dart:convert';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'client.dart';

class Trainer extends Profile with ChangeNotifier {
  // account
  String fullName;
  List<Client> listOfClients;
  int trainerMembershipID;
  int trainerID;
  //profile
  String description, birthday, weight, height, fitnessGoal;

  Trainer({
    firstName,
    lastName,
    this.trainerMembershipID,
    this.listOfClients,
    this.fullName,
    email,
    this.trainerID,
    phoneNumber,
    password,
    this.description,
    this.birthday,
    this.weight,
    this.height,
    this.fitnessGoal,
    profilePicture,
  }) : super(
            firstName: firstName,
            lastName: lastName,
            emailID: email,
            phoneNumber: phoneNumber,
            password: password,
            profilePicture: profilePicture);

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        trainerID: json['trainer_id'],
        description: json['description'],
        birthday: json['birthday'],
        height: json['height'],
        weight: json['weight'],
        fitnessGoal: json['fitness_goal']);
  }

  // Send a POST request to the API to create a new client
  Future<int> createTrainerAccount() async {
    Map data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': emailID,
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
      'email': emailID,
      'tr_password': password,
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/login',
        body: data);

    return Trainer.fromJson(json.decode(response.body));
  }

  // request to API to get the list of clients for a particular trainer id
  Future<List<Client>> getClientList() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/getClientList?trainer_id=$trainerID');

    // 1. Create a List of Users
    final List<Client> fetchedUserList = [];

    // 2. Decode the response body
    List<dynamic> responseData = jsonDecode(response.body);

    // 3. Iterate through all the users in the list
    responseData?.forEach((dynamic userData) {
      // 4. Create a new user and add to the list
      final Client client = Client.fromJson(userData);
      fetchedUserList.add(client);
    });

    // 5. Update our list and the UI
    this.listOfClients = fetchedUserList;
    return fetchedUserList;
  }

  // Send a POST request to the API to log the client in
  Future<int> updateTrainerProfile() async {
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

    return response.statusCode;
  }

  // Send a POST request to the API to log the client in
  Future<Trainer> getTrainerProfile() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/getProfile?trainer_id=' +
            "$trainerID");

    return Trainer.fromJson(json.decode(response.body));
  }

  Future<int> addClient(String clientEmail) async {

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/addClient?'
            'trainer_id=$trainerID&client_email=$clientEmail',);
    final Client client = Client.fromJson(jsonDecode(response.body));
    this.listOfClients.add(client);
    return response.statusCode;
  }
}
