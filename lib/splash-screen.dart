import 'package:fitnesstracker/decorations.dart';
import 'package:fitnesstracker/ui/loginRegistrationPage/login_register_page.dart';
import 'package:fitnesstracker/secure_store_mixin.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'entities/client.dart';
import 'entities/trainer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SecureStoreMixin {
  @override
  Widget build(BuildContext context) {
    _convertAsyncToNot();
    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient: Decorations.backgroundGradient,
        ),
        child: Center(
          child: Text(
            "Fitness Tracker",
            style: Decorations.splashScreen,
          ),
        ),
      ),
    );
  }

  void _convertAsyncToNot() async {
    await _attemptLogin();
  }

  _attemptLogin () async {
    String userType = await getSecureStore("userType");
    String password = await getSecureStore("password");
    String userName = await getSecureStore("email");
    if (userType == null || password == null || userName == null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/', isInitialRoute: true),
          builder: (builder) => LoginRegister(),
        )
      );
    }
    switch (userType) {
      case "Client":
        Client previousClient = Client();
        previousClient.emailID = userName;
        previousClient.password = password;
        previousClient = await previousClient.loginClient();
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: '/', isInitialRoute: true),
              builder: (builder) => App<Client>(user: previousClient, trainerView: false,),
            )
        );
        break;
      case "Trainer":
        Trainer previousTrainer = Trainer();
        previousTrainer.emailID = userName;
        previousTrainer.password = password;
        previousTrainer = await previousTrainer.loginTrainer();
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: '/', isInitialRoute: true),
              builder: (builder) => App<Trainer>(user: previousTrainer, trainerView: false,),
            )
        );
        break;
    }
  }

}