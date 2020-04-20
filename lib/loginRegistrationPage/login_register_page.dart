import 'package:fitnesstracker/customWidgets/custom_filled_button.dart';
import 'package:fitnesstracker/customWidgets/custom_outline_button.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/loginRegistrationPage/login_form.dart';
import 'package:fitnesstracker/loginRegistrationPage/register_form.dart';
import 'package:fitnesstracker/secure_store_mixin.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../decorations.dart';
import '../main.dart';

enum UserType {Client, Trainer}

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> with SecureStoreMixin {
  final ScaffoldState state = new ScaffoldState();

  void initState() {
    super.initState();
    _convertAsyncToNot();
  }

  void _convertAsyncToNot() async {
    await _attemptLogin();
  }

  _attemptLogin () async {
    String userType = await getSecureStore("userType");
    String password = await getSecureStore("password");
    String userName = await getSecureStore("email");
    if (userType == null || password == null || userName == null) {
      return;
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

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    void createLoginSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) => LoginForm(),
      );
    }

    void createRegisterSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) => RegisterForm(),
      );
    }

    return Container(
        decoration: BoxDecoration(
          gradient: Decorations.backgroundGradient,
        ),
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            //backgroundColor: Theme.of(context).primaryColor,
            body: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.5,),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Fitness Tracker",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                Padding(
                  child: Container(
                    child: CustomFilledButton(
                      text: "Login",
                      splashColor: primaryColor,
                      highlightColor: Colors.white,
                      fillColor: Colors.white,
                      textColor: primaryColor,
                      onPressed: createLoginSheet,
                    ),
                    height: 55,
                  ),
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: 20,
                      right: 20),
                ),
                Padding(
                  child: Container(
                    child: CustomOutlineButton(text: "Register", onPressed: createRegisterSheet),
                    height: 50,
                  ),
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            )
        )
    );
  }
}