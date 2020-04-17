import 'dart:convert';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:http/http.dart' as http;
class Client extends Profile {
  // account
  String firstName, lastName, fullName, phoneNumber, email, password;
  int clientID;
  int trainerID; // ID of the trainer assigned to the client

  //profile
  String description, birthday, weight, height, fitnessGoal, profilePicture;

  Client({
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.clientID,
    this.trainerID,
    this.phoneNumber,
    this.password,
    this.description,
    this.birthday,
    this.weight,
    this.height,
    this.fitnessGoal,
    this.profilePicture});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        clientID: json['client_id']
    );
  }

  // Send a POST request to the API to create a new client
  Future<int> createClientAccount() async {
    Map data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
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
      'email': email,
      'cl_password': password,
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/client/login',
        body: data);

    return Client.fromJson(json.decode(response.body));
  }

  // Send a POST request to the API to log the client in
  Future<Client> updateClientProfile() async {
    Map data = {
      'description': description,
      'birthday': birthday,
      'weight': weight,
      'height': height,
      'fitnessGoal': fitnessGoal
    };

    final http.Response response = await http.put(
        'https://mad-fitnesstracker.herokuapp.com/api/client/updateprofile',
        body: data);

    //return response.statusCode;
    return Client.fromJson(json.decode(response.body));
  }
}