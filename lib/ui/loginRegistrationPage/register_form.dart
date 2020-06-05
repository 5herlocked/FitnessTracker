import 'package:fitnesstracker/app.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/secure_store_mixin.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/decorations.dart';
import 'login_register_page.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  UserType userType = UserType.Client;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.transparent),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0)
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.1,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                          color: Theme.of(context).primaryColor,
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
                    Container(
                      padding: EdgeInsets.only(bottom: 20, top: 30),
                      child: Text(
                        "Let's Get Started!",
                        style: Decorations.welcomeBack,
                      ),
                      alignment: Alignment.center,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Create an account with us.",
                        style: Decorations.logIn,
                      ),
                      alignment: Alignment.center,
                    ),
                    MyRegisterForm(),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyRegisterForm extends StatefulWidget {
  @override
  _MyRegisterFormState createState() => _MyRegisterFormState();
}

class _MyRegisterFormState extends State<MyRegisterForm> with SecureStoreMixin {
  final _formKey = GlobalKey<FormState>();
  Profile _user;
  var _email;
  var _password;
  var _displayName;
  var _phoneNumber;
  bool _loading = false;
  UserType userType = UserType.Client;

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
  }

  _buildForm(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: UserType.Client,
                    groupValue: userType,
                    autofocus: true,
                    activeColor: Decorations.accentColour,
                    onChanged: (UserType value) {
                      setState(() => userType = value);
                    },
                  ),
                  Text('Client', style: Decorations.radioButtonLabel),
                  Radio(
                    value: UserType.Trainer,
                    groupValue: userType,
                    autofocus: true,
                    activeColor: Decorations.accentColour,
                    onChanged: (UserType value) {
                      setState(() => userType = value);
                    },
                  ),
                  Text('Trainer', style: Decorations.radioButtonLabel),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    decoration: Decorations.createInputDecoration(
                        Icons.person, "First and Last Name"),
                    enabled: true,
                    cursorColor: Decorations.accentColour,
                    validator: (input) => input.isEmpty ? "*Required" : null,
                    onSaved: (input) => _displayName = input,
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    decoration: Decorations.createInputDecoration(
                        Icons.phone, "Phone Number"),
                    enabled: true,
                    cursorColor: Decorations.accentColour,
                    validator: (input) => input.isEmpty ? "*Required" : null,
                    onSaved: (input) => _phoneNumber = input,
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    decoration:
                        Decorations.createInputDecoration(Icons.email, "Email"),
                    enabled: true,
                    cursorColor: Decorations.accentColour,
                    validator: (input) => input.isEmpty ? "*Required" : null,
                    onSaved: (input) => _email = input,
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    decoration: Decorations.createInputDecoration(
                        Icons.lock, "Password"),
                    enabled: true,
                    cursorColor: Decorations.accentColour,
                    obscureText: true,
                    validator: (input) => input.isEmpty ? "*Required" : null,
                    onSaved: (input) => _password = input,
                  )
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: _loading
                    ? CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Decorations.accentColour),
                      )
                    : Container(
                        child: FlatButton(
                          onPressed: () => _initiateRegister(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          splashColor: Colors.deepOrangeAccent,
                          color: Decorations.accentColour,
                          child: Text(
                            "Register",
                            style: Decorations.subtitle,
                          ),
                        ),
                        height: 55,
                        width: 150,
                      ),
              ),
            ],
          )
      );
    });
  }

  void _initiateRegister() async {
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
    var statusCode;
    var nameArray = _displayName.toString().split(' ');
    switch (userType) {
      case UserType.Client:
        Client newClient = Client();
        newClient.emailID = _email;
        newClient.password = _password;
        newClient.firstName = nameArray[0];
        newClient.lastName = nameArray[1];
        newClient.fullName = _displayName;
        newClient.phoneNumber = _phoneNumber;
        newClient = await newClient.createClientAccount();
        if (newClient.clientID == null)
          _buildError();
        else {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  settings: const RouteSettings(name: '/'),
                  builder: (builder) => new App<Client> (user: newClient, trainerView: false,),
              )
          );
          await _writeToSecure<Client>(_email, _password);
        }
        break;
      case UserType.Trainer:
        Trainer newTrainer = Trainer();
        newTrainer.emailID = _email;
        newTrainer.password = _password;
        newTrainer.firstName = nameArray[0];
        newTrainer.lastName = nameArray[1];
        newTrainer.fullName = _displayName;
        newTrainer.phoneNumber = _phoneNumber;
        newTrainer = await newTrainer.createTrainerAccount();
        if (newTrainer.trainerID == null)
          _buildError();
        else {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  settings: const RouteSettings(name: '/'),
                  builder: (builder) => new App<Trainer>(user: newTrainer, trainerView: false,),
              )
          );
          await _writeToSecure<Trainer>(_email, _password);
        }
        break;
    }
  }

  _buildError() {
    var errorMsg;
    setState(() {
      errorMsg =
      "There has been an error processing your request. Please try again.";
      _loading = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Registration Error"),
              content: Container(
                child: Text(errorMsg),
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
          }
      );
    });
  }

  Future<void> _writeToSecure <T extends Profile> (String userName, String password) async {
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
