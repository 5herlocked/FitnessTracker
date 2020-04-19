import 'package:fitnesstracker/app.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/entities/client.dart';
import '../decorations.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return DecoratedBox(
          decoration: BoxDecoration(color: Colors.transparent),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            child: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Decorations.accentColour,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
                          child: CircleAvatar(
                            backgroundImage: new NetworkImage(
                                "https://19yw4b240vb03ws8qm25h366-wpengine.netdna-ssl.com/wp-content/uploads/Profile-Pic-Circle-Grey-Large.png"),
                            radius: 80.0,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Welcome Back",
                              style: Decorations.welcomeBack,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 10,
                            ),
                            child: Text(
                              "Login to your existing account.",
                              style: Decorations.logIn,
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        MyLoginForm(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ));
    });
  }
}

class MyLoginForm extends StatefulWidget {
  @override
  _MyLoginFormState createState() => _MyLoginFormState();
}

class _MyLoginFormState extends State<MyLoginForm> {
  final _formKey = GlobalKey<FormState>();
  Profile _user;
  var _userEmail;
  var _userPassword;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
  }

  _buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                validator: (value) => (value.isEmpty) ? "*Required" : null,
                enabled: true,
                cursorColor: Decorations.accentColour,
                decoration:
                    Decorations.createInputDecoration(Icons.mail, "Email"),
                onChanged: (value) => _userEmail = value,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                obscureText: true,
                validator: (value) => (value.isEmpty) ? "*Required" : null,
                enabled: true,
                cursorColor: Decorations.accentColour,
                decoration:
                    Decorations.createInputDecoration(Icons.lock, "Password"),
                onChanged: (value) => _userPassword = value,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: _loading == true
                  ? CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Decorations.accentColour),
                    )
                  : Container(
                      child: FlatButton(
                        onPressed: () => _initiateLogin(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        splashColor: Colors.deepOrangeAccent,
                        color: Decorations.accentColour,
                        child: Text(
                          "Login",
                          style: Decorations.loginRegButton,
                        ),
                      ),
                      height: 55,
                      width: 150,
                    ),
            ),
          ],
        ));
  }

  void _initiateLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _loading = true;
      });
      _user = await _backendCall();
      setState(() {
        _loading = false;
      });
    }
  }

  Future<Profile> _backendCall() async {
    Client possibleClient = new Client();
    Trainer possibleTrainer = new Trainer();

    possibleClient.emailID = _userEmail;
    possibleClient.password = _userPassword;

    possibleTrainer.emailID = _userEmail;
    possibleTrainer.password = _userPassword;

    try {
      possibleClient = await possibleClient.loginClient();
      possibleTrainer = await possibleTrainer.loginTrainer();
    } catch (Exception) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Login Error"),
              content: Container(
                child: Text("Unexpected error. Please try again later."),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
    if (possibleClient.clientID == null && possibleTrainer.trainerID == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Login Error"),
              content: Container(
                child: Text("Account not found. Please register."),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      Navigator.popUntil(context, (route) => route.isFirst);
      if (possibleClient.clientID != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: '/'),
              builder: (builder) => new App<Client>(user: possibleClient, trainerView: false,),
            )
        );
        return possibleClient;
      }
      if (possibleTrainer.trainerID != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: '/'),
              builder: (builder) => new App<Trainer>(user: possibleTrainer, trainerView: false,),
            )
        );
        return possibleTrainer;
      } else
        return null;
    }
  }
}
