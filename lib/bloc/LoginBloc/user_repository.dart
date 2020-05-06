import 'package:fitnesstracker/secure_store_mixin.dart';
import 'package:flutter/material.dart';

class UserReporsitory with SecureStoreMixin {
  Future<String> authenticate ({
    @required String username,
    @required String password,
  }) async {
    String token = "token";
    // call the auth API call
    await persistToken(token);
  }

  // logout logic
  Future<void> deleteToken() async {
    // delete auth token from secure store
    clearAll();
    return;
  }

  Future<void> persistToken (String token) async {
    // write to secure store
    setSecureStore("authToken", token);
    return;
  }

  Future<bool> hasToken() async {
    // read from secure store
    String token = await getSecureStore("authToken");
    return ((token != null) && token.isNotEmpty);
  }
}