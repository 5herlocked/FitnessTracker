import 'package:fitnesstracker/app.dart';
import 'package:fitnesstracker/loginRegistrationPage/login_register_page.dart';
import 'package:fitnesstracker/secure_store_mixin.dart';
import 'package:fitnesstracker/splash-screen.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
          brightness: Brightness.light,
          hintColor: Color(0xFFc6c6c6),
          primaryColor: Color(0xFFFA716F),
          canvasColor: Colors.transparent,
          fontFamily: "Raleway",
      ),
      home: SplashScreen(),
    );
  }
}