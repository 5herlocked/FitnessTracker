import 'package:fitnesstracker/app.dart';
import 'package:fitnesstracker/customWidgets/custom_text_field.dart';
import 'package:fitnesstracker/customWidgets/custom_filled_button.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/entities/client.dart';
import 'login_register_page.dart';

class RegisterForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final PersistentBottomSheetController sheetController;

  RegisterForm({this.scaffoldKey, this.formKey, this.sheetController});

  @override
  State<StatefulWidget> createState() {
    return RegisterFormState(scaffoldKey: scaffoldKey, formKey: formKey, sheetController: sheetController);
  }
}

class RegisterFormState extends State<RegisterForm> {
  String _email;
  String _password;
  String _displayName;
  String _phoneNumber;
  String _trainerMembershipID;
  bool _loading = false;
  bool _autoValidate = false;
  String errorMsg = "";
  UserType userType = UserType.Client;
  bool isUserTypeClient = true;

  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  PersistentBottomSheetController sheetController;

  RegisterFormState({this.scaffoldKey, this.formKey, this.sheetController});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter state) {
          return DecoratedBox(
            decoration: BoxDecoration(color: Theme.of(context).canvasColor),
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
                        child: Form(
                          child: Column(children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 20, top: 30),
                              child: Text(
                                "Let's Get Started!",
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
                                "Create an account with us.",
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
                            Visibility(
                              visible: isUserTypeClient? false: true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 20,
                                  ),
                                  child: CustomTextField(
                                    icon: Icon(Icons.person),
                                    maxLines: 1,
                                    hint: "Trainer ID",
                                    validator: (input) =>
                                    input.isEmpty ? "*Required" : null,
                                    onSaved: (input) => _trainerMembershipID = input,
                                  )),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                  top: 20,
                                ),
                                child: CustomTextField(
                                  icon: Icon(Icons.person),
                                  maxLines: 1,
                                  hint: "First and Last Name",
                                  validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                                  onSaved: (input) => _displayName = input,
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: CustomTextField(
                                  icon: Icon(Icons.phone),
                                  hint: "Phone",
                                  maxLines: 1,
                                  validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                                  onSaved: (input) => _phoneNumber = input,
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: CustomTextField(
                                  icon: Icon(Icons.email),
                                  maxLines: 1,
                                  hint: "Email",
                                  onSaved: (input) {
                                    _email = input;
                                  },
                                  validator: validateEmail,
                                )),
                            Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: CustomTextField(
                                  icon: Icon(Icons.lock),
                                  obscure: true,
                                  onSaved: (input) => _password = input,
                                  validator: (input) =>
                                  input.isEmpty ? "*Required" : null,
                                  hint: "Password",
                                  maxLines: 1,
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: _loading
                                  ? CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    primaryColor),
                              )
                                  : Container(
                                child: CustomFilledButton(
                                  text: "Register",
                                  splashColor: Colors.white,
                                  highlightColor: primaryColor,
                                  fillColor: primaryColor,
                                  textColor: Colors.white,
                                  onPressed: _validateRegisterInput,
                                ),
                                height: 50,
                                width: 150,
                                //width: MediaQuery.of(context).size.width,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]),
                          key: formKey,
                          autovalidate: _autoValidate,
                        )),
                  ],
                ),
                height: MediaQuery.of(context).size.height / 1.1,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
            ),
          );
        }
    );
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

  void _validateRegisterInput() async {
    final FormState form = formKey.currentState;
    if (formKey.currentState.validate()) {
      form.save();
      sheetController.setState(() {
        _loading = true;
      });

      Trainer trainer = new Trainer();
      Client client = new Client();
      int statusCode;
      var arr = _displayName.split(' ');

      if (userType == UserType.Trainer) {
        trainer.firstName = arr[0].trim();
        trainer.lastName = arr[1].trim();
        trainer.fullName = _displayName;
        trainer.phoneNumber = _phoneNumber;
        trainer.email = _email;
        trainer.password = _password;
        trainer.trainerMembershipID = _trainerMembershipID;

        // Call the API to create a new user in the database
        statusCode = await trainer.createTrainerAccount();

      } else {
        client.firstName = arr[0].trim();
        client.lastName = arr[1].trim();
        client.fullName = _displayName;
        client.phoneNumber = _phoneNumber;
        client.email = _email;
        client.password = _password;

        // Call the API to create a new user in the database
        statusCode = await client.createClientAccount();
      }

      if (statusCode != 200) {
        sheetController.setState(() {
          errorMsg = "There has been an error processing your request. Please try again.";
          _loading = false;
        });
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
            });
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