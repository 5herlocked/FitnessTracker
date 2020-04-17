import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstracker/customWidgets/custom_text_field.dart';
import 'package:fitnesstracker/customWidgets/custom_filled_button.dart';

import '../decorations.dart';

class ProfilePage<T extends Profile> extends StatefulWidget {
  final T client;
  ProfilePage({Key key, this.client}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _birthday, _description, _weight, _height, _fitnessGoal;
  bool _loading = false;
  bool _isEnabled = false;
  bool _isSaveButtonVisible = false;
  bool _autoValidate = false;
  String errorMsg = "";
  String dropdownValue ='One';

  void initState() {
    super.initState();
  }

  void _saveProfile() async {
    final FormState form = _formKey.currentState;
    form.save();
    Client client = new Client();
    client.description = _description;
    client.birthday = _birthday;
    client.weight = _weight;
    client.height = _height;
    client.fitnessGoal = _fitnessGoal;
    // Call the API to update the client's profile in the database
    //final statusCode = await  clientUser.updateClientProfile();
    //clientUser = await clientUser.updateClientProfile();
    final statusCode = 200;
    if (statusCode != 200) {
      setState(() {
        errorMsg = "There has been an error processing your request. Please try again.";
        _loading = false;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Profile Update Error"),
              content: Container(
                child: Text(errorMsg),
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _isEnabled = false; // lock the text field
                      _isSaveButtonVisible = false; // hide the save button
                      _loading = false;
                    });
                  },
                ),
              ],
            );
          });
    } else {
      setState(() {
        _isEnabled = false;
        _isSaveButtonVisible = false;
        _loading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[],
          elevation: 0.0,
          title: Text("Profile", style: TextStyle(fontFamily: 'Raleway'),),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                    Visibility(
                      visible: _isEnabled,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        child: Text(
                          "Choose to select a new photo.",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Raleway',
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        widget.client.firstName + "  " + widget.client.lastName,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CustomTextField(
                          //icon: Icon(Icons.description),
                          onSaved: (input) => _description = input,
                          validator: (input) =>
                          input.isEmpty ? "*Required" : null,
                          maxLines: 2,
                          labelText: "Description",
                          hint: _description == null ? "Description" : _description,
                          isEnabled: _isEnabled ? true : false,
                        ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CustomTextField(
                          icon: Icon(Icons.calendar_today),
                          onSaved: (input) => _birthday = input,
                          validator: (input) =>
                          input.isEmpty ? "*Required" : null,
                          maxLines: 1,
                          labelText: "Birthday MM/DD/YYYY",
                          hint: _birthday == null ? "Birthday MM/DD/YYYY" : _birthday,
                          isEnabled: _isEnabled ? true : false,
                        )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Flexible(
                            child: Container(
                              width: 300,
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: CustomTextField(
                                    //icon: Icon(Icons.calendar_today),
                                    onSaved: (input) => _height = input,
                                    validator: (input) =>
                                    input.isEmpty ? "*Required" : null,
                                    maxLines: 1,
                                    labelText: "Height",
                                    hint: _height == null ? "Height" : _height,
                                    isEnabled: _isEnabled ? true : false,
                                  )
                              ),
                            )
                        ),
                        new Flexible(
                            child: Container(
                              width: 300,
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: CustomTextField(
                                    //icon: Icon(Icons.calendar_today),
                                    onSaved: (input) => _weight = input,
                                    validator: (input) =>
                                    input.isEmpty ? "*Required" : null,
                                    labelText: "Weight",
                                    maxLines: 1,
                                    hint: _weight == null ? "Weight" : _weight,
                                    isEnabled: _isEnabled ? true : false,
                                  )
                              ),
                            )
                        ),
                      ],
                    ),

                    Padding(
                        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: TextFormField(
                          enabled: _isEnabled,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: "Fitness Goal",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Decorations.accentColour,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        )
                      /*TextField(
                          enabled: _isEnabled,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            labelText: "Fitness Goal",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Decorations.accentColour,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          cursorColor: Decorations.accentColour,
                        ),*/
                      /*CustomTextField(
                          icon: Icon(Icons.fitness_center),
                          onSaved: (input) => _fitnessGoal = input,
                          validator: (input) =>
                          input.isEmpty ? "*Required" : null,
                          labelText: "Fitness Goal",
                          maxLines: 1,
                          hint: _fitnessGoal == null ? "Birthday MM/DD/YYYY" : _fitnessGoal,
                          isEnabled: _isEnabled ? true : false,
                        )*/
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
                            primaryColor),
                      )
                          : Container(
                        child: Visibility (
                          visible: _isSaveButtonVisible,
                          child: CustomFilledButton(
                            text: "Save",
                            splashColor: Colors.white,
                            highlightColor: primaryColor,
                            fillColor: primaryColor,
                            textColor: Colors.white,
                            onPressed: _saveProfile,
                          )
                        ),
                        height: 55,
                        width: 150,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
          ),
        ),
        floatingActionButton: new Visibility(
          // if the text fields are enabled, then the floating action button
          // should be invisible
            visible: !_isEnabled,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isEnabled = true; // enable the text fields
                  _isSaveButtonVisible = true; // display the save button
                });
              },
              child: Icon(Icons.edit),
              backgroundColor: primaryColor,
            )
        )
    );
  }
}