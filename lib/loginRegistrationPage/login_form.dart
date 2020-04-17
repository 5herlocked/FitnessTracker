import 'dart:async';

import 'package:fitnesstracker/app.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/decorations.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'login_register_page.dart';

class LoginForm extends StatefulWidget {
  _LoginFormState createState() => _LoginFormState();

  LoginForm({Key key}) : super (key: key);
}

class _LoginFormState extends State<LoginForm> {
  String errorMsg = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 92/100,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(40),
            topRight: const Radius.circular(40),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              left: 10,
              top: 10,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Decorations.accentColour,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60, bottom: 10,),
                  child: CircleAvatar(
                    backgroundImage: new NetworkImage("https://19yw4b240vb03ws8qm25h366-wpengine.netdna-ssl.com/wp-content/uploads/Profile-Pic-Circle-Grey-Large.png"),
                    radius: 80.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Welcome Back",
                    style: Decorations.welcomeBack,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10,),
                  child: Text(
                    "Login to your existing account.",
                    style: Decorations.logIn,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: MyLoginForm(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyLoginForm extends StatefulWidget {
  @override
  _MyLoginFormState createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final _formKey = GlobalKey<FormState>();
  Profile user;
  var _userEmail;
  var _userPassword;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    var formContents = Stack(
      children: _buildForm(context),
    );
    return formContents;
  }

  List<Widget> _buildForm(BuildContext context) {
    Form form = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              validator: (value) => (value.isEmpty) ? "Enter an email" : null,
              enabled: true,
              cursorColor: Decorations.accentColour,
              decoration: Decorations.createInputDecoration(Icons.mail, "Email"),
              onChanged: (value) => _userEmail = value,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              obscureText: true,
              enabled: true,
              cursorColor: Decorations.accentColour,
              decoration: Decorations.createInputDecoration(Icons.lock, "Password"),
              onChanged: (value) => _userPassword = value,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              width: 140,
              child: FlatButton(
                onPressed: () => _initiateLogin(),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                splashColor: Colors.deepOrangeAccent,
                color: Decorations.accentColour,
                child: Text(
                  "Login",
                  style: Decorations.subtitle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    var formList = List<Widget>();
    formList.add(form);
    if (_loading) {
      var modal = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false,),
            ),
            Center(
              child: LoadingBouncingGrid.square(
                backgroundColor: Decorations.accentColour,
              ),
            )
          ],
        ),
      );
      formList.add(modal);
    }
    return formList;
  }

  void _initiateLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });
      user = await _backendCall();
      setState(() {
        _loading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (builder) => new App(client: user,),
        )
      );
    }
  }

  Future<Profile> _backendCall() async {
    Client possibleClient = new Client();
    Trainer possibleTrainer = new Trainer();

    possibleClient.email = _userEmail;
    possibleClient.password = _userPassword;

    possibleTrainer.email = _userEmail;
    possibleTrainer.password = _userPassword;

    try {
      possibleClient = await possibleClient.loginClient();
      possibleTrainer = await possibleTrainer.loginTrainer();
    } catch (Exception) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Unexpected Error, please try later"),
        ),
      );
    }
    if (possibleClient.clientID == null && possibleTrainer.trainerID == null) {
      Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("No account detected, please register"),
          )
      );
    } else {
      if (possibleClient.clientID != null) {
        return possibleClient;
      }
      if (possibleTrainer.trainerID != null) {
        return possibleTrainer;
      }
      else return null;
    }
  }
}