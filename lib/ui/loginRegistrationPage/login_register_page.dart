import 'package:fitnesstracker/decorations.dart';
import 'package:fitnesstracker/customWidgets/custom_filled_button.dart';
import 'package:fitnesstracker/customWidgets/custom_outline_button.dart';
import 'package:fitnesstracker/ui/loginRegistrationPage/login_form.dart';
import 'package:fitnesstracker/ui/loginRegistrationPage/register_form.dart';
import 'package:fitnesstracker/secure_store_mixin.dart';

import 'package:flutter/material.dart';

enum UserType {Client, Trainer}

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> with SecureStoreMixin {
  final ScaffoldState state = new ScaffoldState();

  void initState() {
    super.initState();
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
                    style: Decorations.splashScreen,
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