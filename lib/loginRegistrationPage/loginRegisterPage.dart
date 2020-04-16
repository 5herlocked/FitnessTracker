import 'package:fitnesstracker/customWidgets/customFilledButton.dart';
import 'package:fitnesstracker/customWidgets/customOutlineButton.dart';
import 'package:fitnesstracker/loginRegistrationPage/loginForm.dart';
import 'package:fitnesstracker/loginRegistrationPage/registerForm.dart';
import 'package:flutter/material.dart';

import '../decorations.dart';

enum UserType {Client, Trainer}

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _sheetController;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    void createLoginSheet() {
      _sheetController = _scaffoldKey.currentState
          .showBottomSheet<void>((BuildContext context) {
        return LoginForm(
          scaffoldKey: _scaffoldKey,
          formKey: _formKey,
          sheetController: _sheetController,
        );
      });
    }

    void createRegisterSheet() {
      _sheetController = _scaffoldKey.currentState
          .showBottomSheet<void>((BuildContext context) {
        return RegisterForm(
          scaffoldKey: _scaffoldKey,
          formKey: _formKey,
          sheetController: _sheetController,
        );
      });
    }

    return Container(
        decoration: BoxDecoration(
          gradient: Decorations.backgroundGradient,
        ),
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            key: _scaffoldKey,
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