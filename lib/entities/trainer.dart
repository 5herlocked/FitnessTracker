import 'dart:convert';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:http/http.dart' as http;

import 'client.dart';

class Trainer extends Profile {
  // account
  String fullName;
  String credentials;
  List<Client> listOfClients;
  int trainerMembershipID;
  int trainerID;

  Trainer({
    firstName,
    lastName,
    this.trainerMembershipID,
    this.listOfClients,
    this.fullName,
    email,
    this.trainerID,
    this.credentials,
    phoneNumber,
    password,
    profileAttributes,
    profilePicture,
  }) : super(
    firstName: firstName,
    lastName: lastName,
    emailID: email,
    phoneNumber: phoneNumber,
    password: password,
    profilePicture: "https://19yw4b240vb03ws8qm25h366-wpengine.netdna-ssl.com/wp-content/uploads/Profile-Pic-Circle-Grey-Large.png",
    profileAttributes: profileAttributes,
  );

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      trainerID: json['trainer_id'],
      credentials: json['credentials'],
      profileAttributes: json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null,
    );
  }

  // Send a POST request to the API to create a new client
  Future<Trainer> createTrainerAccount() async {
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

    return Trainer.fromJson(json.decode(response.body));
  }

  // Send a POST request to the API to log the client in
  Future<Trainer> loginTrainer() async {
    Map data = {
      'email': emailID,
      'tr_password': password,
    };

    final http.Response response = await http.post(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/login',
        body: data
    );

    return Trainer.fromJson(json.decode(response.body));
  }

  // request to API to get the list of clients for a particular trainer id
  Future<List<Client>> getClientList() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/getClientList?'
            'trainer_id=$trainerID'
    );

    // 1. Create a List of Users
    final List<Client> fetchedUserList = [];

    // 2. Decode the response body
    List<dynamic> responseData = jsonDecode(response.body);

    // 3. Iterate through all the users in the list
    responseData?.forEach((dynamic userData) {
      // 4. Create a new user and add to the list
      final Client client = Client.fromJson(userData);
      client.trainerID == 1? client.isTrainerAssigned = false
          : client.isTrainerAssigned = true;
      fetchedUserList.add(client);
    });

    // 5. Update our list and the UI
    this.listOfClients = fetchedUserList;
    return fetchedUserList;
  }

  // Send a POST request to the API to update the trainer's profile
  Future<int> updateTrainerProfile() async {
    String url;

    if(this.profileAttributes.birthday == null) {
      url = "https://mad-fitnesstracker.herokuapp.com/api/trainer/updateProfile?"
          "trainer_id=$trainerID&bio=${profileAttributes.description}&current_email=$emailID"
          "&credentials=$credentials&goal=${profileAttributes.fitnessGoal}";
    } else {
      url = "https://mad-fitnesstracker.herokuapp.com/api/trainer/updateProfile?"
          "trainer_id=$trainerID&bio=${profileAttributes.description}&current_email=$emailID"
          "&credentials=$credentials&goal=${profileAttributes.fitnessGoal}&dob=${profileAttributes.birthday}";
    }

    final http.Response response = await http.post(url);

    return response.statusCode;
  }

  // Send a POST request to the API to get the trainer's profile
  Future<Trainer> getTrainerProfile() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/getProfile?'
            'trainer_id=$trainerID'
    );

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

  Future<List<Client>> getAllUnassignedClients() async {
    final http.Response response = await http.get(
        'https://mad-fitnesstracker.herokuapp.com/api/trainer/getUnassignedClientList');

    // 1. Create a List of Users
    final List<Client> fetchedUserList = [];

    // 2. Decode the response body
    List<dynamic> responseData = jsonDecode(response.body);

    // 3. Iterate through all the users in the list
    responseData?.forEach((dynamic userData) {
      // 4. Create a new user and add to the list
      final Client client = Client.fromJson(userData);
      client.isTrainerAssigned = false;
      fetchedUserList.add(client);
    });

    // 5. Update our list and the UI
    return fetchedUserList;
  }
}
