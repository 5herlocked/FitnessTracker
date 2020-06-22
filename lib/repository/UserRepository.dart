import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/secure_store_mixin.dart';
import 'package:flutter/material.dart';

// returns and stores tokens for persistent login instead of
// username and password everytime
class UserRepository with SecureStoreMixin {
  Future<String> authenticate(
      {@required String username, @required String password}) async {
    Client possibleClient = new Client();
    Trainer possibleTrainer = new Trainer();

    possibleClient.emailID = username;
    possibleClient.password = password;

    possibleTrainer.emailID = username;
    possibleTrainer.password = password;

    try {
      possibleClient = await possibleClient.loginClient();
      possibleTrainer = await possibleTrainer.loginTrainer();
    } catch (Exception) {

    }

    if (possibleClient.clientID == null && possibleTrainer.trainerID == null) {
      return 'null'; // null token to signify that a user was not found
    }
    else {
      if (possibleClient.clientID != null) {
        await _writeToSecure<Client>(possibleClient.emailID, password);
      }
      if (possibleTrainer.trainerID != null) {
        await _writeToSecure<Trainer>(possibleTrainer.emailID, password);
      }
    }
    return 'token';
  }

  Future<void> _writeToSecure <T extends Profile>(String userName, String password) async {
    String userType;
    switch (T) {
      case Client:
        userType = "Client";
        break;
      case Trainer:
        userType = "Trainer";
        break;
    }
    setSecureStore("email", userName.toString());
    setSecureStore("password", password.toString());
    setSecureStore("userType", userType.toString());
  }
}