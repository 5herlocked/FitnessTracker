import 'package:fitnesstracker/app.dart';
import 'package:fitnesstracker/customWidgets/customTextField.dart';
import 'package:fitnesstracker/customWidgets/customFilledButton.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'loginRegisterPage.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final PersistentBottomSheetController sheetController;

  LoginForm({this.scaffoldKey, this.formKey, this.sheetController});

  @override
  State<StatefulWidget> createState() {
    return LoginFormState(scaffoldKey: scaffoldKey, formKey: formKey, sheetController: sheetController);
  }
}

class LoginFormState extends State<LoginForm> {
  String _email;
  String _password;
  bool _loading = false;
  bool _autoValidate = false;
  String errorMsg = "";
  UserType userType = UserType.Client;
  bool isUserTypeClient = true;

  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  PersistentBottomSheetController sheetController;

  LoginFormState({this.scaffoldKey, this.formKey, this.sheetController});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter state) {
          return DecoratedBox(
            decoration: BoxDecoration(color: Theme
                .of(context)
                .canvasColor),
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
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 30.0,
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 50,
                      width: 50,
                    ),
                    SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          autovalidate: _autoValidate,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 140,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      child: Align(
                                        child: Container(
                                          width: 150,
                                          height: 160,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              //color: Theme.of(context).primaryColor
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: new NetworkImage(
                                                      "https://19yw4b240vb03ws8qm25h366-wpengine.netdna-ssl.com/wp-content/uploads/Profile-Pic-Circle-Grey-Large.png")
                                              )
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: 20, top: 20),
                                child: Text(
                                  "Welcome back!",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black87,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Log in to your existing account.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Raleway',
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Radio(
                                    value: UserType.Client,
                                    groupValue: userType,
                                    autofocus: true,
                                    activeColor: primaryColor,
                                    onChanged: (UserType value) {
                                      state(() {
                                        isUserTypeClient = true;
                                        userType = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Client',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,
                                    ),
                                  ),
                                  Radio(
                                    value: UserType.Trainer,
                                    groupValue: userType,
                                    autofocus: true,
                                    activeColor: primaryColor,
                                    onChanged: (UserType value) {
                                      state(() {
                                        isUserTypeClient = false;
                                        userType = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Trainer',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: CustomTextField(
                                    onSaved: (input) {
                                      _email = input;
                                    },
                                    //validator: emailValidator,
                                    validator: (input) =>
                                    input.isEmpty ? "*Required" : null,
                                    icon: Icon(Icons.email),
                                    maxLines: 1,
                                    hint: "Email",
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: CustomTextField(
                                    icon: Icon(Icons.lock),
                                    obscure: true,
                                    maxLines: 1,
                                    onSaved: (input) => _password = input,
                                    validator: (input) =>
                                    input.isEmpty ? "*Required" : null,
                                    hint: "Password",
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    bottom: MediaQuery
                                        .of(context)
                                        .viewInsets
                                        .bottom),
                                child: _loading == true
                                    ? CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<
                                      Color>(
                                      primaryColor),
                                )
                                    : Container(
                                  child: CustomFilledButton(
                                    text: "Login",
                                    splashColor: Colors.white,
                                    highlightColor: primaryColor,
                                    fillColor: primaryColor,
                                    textColor: Colors.white,
                                    onPressed: _validateLoginInput,
                                  ),
                                  height: 55,
                                  width: 150,
                                  //width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.1,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Colors.white,
              ),
            ),
          );
        });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

  void _validateLoginInput() async {
    final FormState form = formKey.currentState;
    if (formKey.currentState.validate()) {
      form.save();
      sheetController.setState(() {
        _loading = true;
      });

      Client client = new Client();
      Trainer trainer = new Trainer();

      if (isUserTypeClient) {
        client.email = _email;
        client.password = _password;
//        client.clientID = 123;
//        client.firstName = "Tony";
//        client.lastName = "Stark";

        /*
        For debugging purposes or in cases where the server is down
        uncomment the following lines to log the client in
        client.clientID = 123;
        client.firstName = "Tony";
        client.lastName = "Stark";

        and comment out the line below that calls the API
        */

        // Call the API to log the client in
        client = await client.loginClient();
      } else {
        trainer.email = _email;
        trainer.password = _password;
        trainer = await trainer.loginTrainer();
      }
      // if the trainer/client id retrieved in the response from the API is null
      // that means there was an error, so we can display an error message to the user
      // with an alert dialog
      if (isUserTypeClient && client.clientID == null ||
          !isUserTypeClient && trainer.trainerID == null) {
        sheetController.setState(() {
          errorMsg = "There has been an error processing your request. Please try again.";
          _loading = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Login Error"),
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
            });
        // otherwise, if the user has been logged in successfully,
        // navigate to the home page
      } else {
        sheetController.setState(() {
          _loading = false;
        });
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(
                settings: const RouteSettings(name: '/app'),
                builder: (context) => new App(client: client,)
            )
        );
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}