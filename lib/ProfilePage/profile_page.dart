import 'package:fitnesstracker/entities/client.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/trainer.dart';
import 'package:fitnesstracker/loginRegistrationPage/login_register_page.dart';
import 'package:fitnesstracker/secure_store_mixin.dart';
import 'package:flutter/material.dart';
import '../decorations.dart';

class ProfilePage<T extends Profile> extends StatefulWidget {
  T user;
  bool isAlternateView = false;

  ProfilePage({Key key, this.user, this.isAlternateView}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState<T>();
}

class _ProfilePageState<T extends Profile> extends State<ProfilePage>
    with SecureStoreMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEnabled = false;
  bool isNewUser = false;
  bool _isSaveButtonVisible = false;
  bool _isEditButtonVisible = true;
  String _birthday, _description, _weight, _height, _fitnessGoal, _credentials;
  bool _loading = false;
  bool _autoValidate = false;
  String errorMsg = "";
  Client client;
  Trainer trainer;

  @override
  void initState() {
    switch(T) {
      case Trainer:
        Trainer trainer;
        getTrainerProfile().then((value) {
          setState(() {
            trainer = value;
            setTrainerFields(trainer);
          });
        });
        break;
      case Client:
        Client client;
        getClientProfile().then((value) {
          setState(() {
            client = value;
            setClientFields(client);
          });
        });
    }
    super.initState();
  }

  Future<Client> getClientProfile() async {
    Client client = widget.user as Client;
    if (widget.isAlternateView) {
      // trainer is viewing client's profile
      // disable editing permissions
      _isEditButtonVisible = false;
    }
    return await client.getClientProfile();
  }

  void setClientFields(Client client) {
    if(client.profileAttributes != null && client.profileAttributes.description == null && client.profileAttributes.birthday == null
        && client.profileAttributes.fitnessGoal == null && client.profileAttributes.height == 0 &&
        client.profileAttributes.weight == 0) {
      isNewUser = true;
    }else {
      _description =  client.profileAttributes.description;
      _birthday =  client.profileAttributes.birthday;
      _height =  client.profileAttributes.height.toString();
      _weight =  client.profileAttributes.weight.toString();
      _fitnessGoal = client.profileAttributes.fitnessGoal;
    }
  }

  Future<Trainer> getTrainerProfile() async {
    Trainer trainer = widget.user as Trainer;
    if (widget.isAlternateView) {
      // client is viewing trainer's profile
      // disable editing permissions
      _isEditButtonVisible = false;
    }
    return await trainer.getTrainerProfile();
  }

  void setTrainerFields(Trainer trainer) {
    if ((trainer.profileAttributes.description == null && trainer.profileAttributes.birthday == null
        && trainer.profileAttributes.fitnessGoal == null && trainer.credentials == null)){
      isNewUser = true;
    }else {
      _description = trainer.profileAttributes.description;
      _birthday = trainer.profileAttributes.birthday;
      _fitnessGoal = trainer.profileAttributes.fitnessGoal;
      _credentials = trainer.credentials;
    }
  }

  // build app bar with logout icon for trainer and client
  _buildAppBar() {
    return AppBar(
      actions: <Widget>[
        Visibility(
          visible: !widget.isAlternateView,
            child: IconButton(
                icon: Icon(Icons.exit_to_app), onPressed: () => _clearCredentials()
            )
        ),
      ],
      elevation: 0.0,
      title: Text(
        "Profile",
        style: TextStyle(fontFamily: 'Raleway'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.profilePicture),
                      radius: 80.0,
                    ),
                  ),
                  Visibility(
                    visible: _isEnabled,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 20, right: 20, bottom: 10),
                      child: Text("Choose to select a new photo.",
                          style: Decorations.logIn),
                      alignment: Alignment.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10.0, left: 20, right: 20, bottom: 10),
                    child: Text(
                      widget.user.firstName + "  " + widget.user.lastName,
                      style: Decorations.profileUserName,
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _description == null && !isNewUser? new Container() : _buildForm(),
                ],
              ),
            )),
        floatingActionButton: new Visibility(
          // if the text fields are enabled, then the floating action button
          // should be invisible
            visible: !_isEnabled && _isEditButtonVisible,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isEnabled = true; // enable the text fields
                  _isSaveButtonVisible = true; // display the save button
                  _isEditButtonVisible = false;
                });
              },
              child: Icon(Icons.edit),
              backgroundColor: Decorations.accentColour,
            )));
  }

  void _saveProfile() async {
    final FormState form = _formKey.currentState;
    setState(() {
      _loading = true;
    });
    form.save();
    int statusCode;
    switch (T) {
      case Client:
        Client client = widget.user as Client;
        Attributes profileAttributes = new Attributes();
        profileAttributes.description = _description;
        profileAttributes.fitnessGoal = _fitnessGoal;

        if(_height != "") {
          profileAttributes.height = int.parse(_height);
        }else {
          profileAttributes.height = 0;
        }

        if(_weight != "") {
          profileAttributes.weight = int.parse(_weight);
        }else {
          profileAttributes.weight = 0;
        }

        if(_birthday != "") {
          var parsedDate = DateTime.parse(_birthday);
          profileAttributes.birthday =  parsedDate.toIso8601String();
        }

        client.profileAttributes = profileAttributes;

        // Call the API to update the client's profile in the database
        statusCode = await client.updateClientProfile();
        break;
      case Trainer:
        Trainer trainer = widget.user as Trainer;

        Attributes profileAttributes = new Attributes();
        profileAttributes.description = _description;
        profileAttributes.fitnessGoal = _fitnessGoal;

        if(_birthday != "") {
          var parsedDate = DateTime.parse(_birthday);
          profileAttributes.birthday =  parsedDate.toIso8601String();
        }

        trainer.credentials = _credentials;
        trainer.profileAttributes = profileAttributes;

        // Call the API to update the client's profile in the database
        statusCode = await trainer.updateTrainerProfile();
        break;
    }

    if (statusCode != 200) {
      setState(() {
        errorMsg =
        "There has been an error processing your request. Please try again.";
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
                      _isEditButtonVisible = true;
                    });
                  },
                ),
              ],
            );
          });
    } else {
      setState(() {
        _isEnabled = false;
        _isEditButtonVisible = true;
        _isSaveButtonVisible = false;
        _loading = false;
      });
    }
  }

  // Build the Profile Form
  Widget _buildForm() {
    return Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            Padding(
              padding:
              EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
              child: TextFormField(
                initialValue: _description,
                onSaved: (input) => _description = input,
                cursorColor: Decorations.accentColour,
                validator: (input) => input.isEmpty ? "*Required" : null,
                maxLines: 2,
                decoration: Decorations.createInputDecoration(
                    Icons.perm_contact_calendar, "Description"),
                enabled: _isEnabled ? true : false,
              ),
            ),
            Visibility(
              visible: widget.user is Trainer? true : false,
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    initialValue: _credentials,
                    enabled: _isEnabled ? true : false,
                    onSaved: (input) => _credentials = input,
                    validator: (input) => input.isEmpty ? "*Required" : null,
                    cursorColor: Decorations.accentColour,
                    decoration: Decorations.createInputDecoration(
                        Icons.star, "Credentials"),
                  ))
            ),
            Padding(
                padding:
                EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                child: TextFormField(
                  initialValue: _birthday,
                  onSaved: (input) => _birthday = input,
                  cursorColor: Decorations.accentColour,
                  validator: (input) => input.isEmpty ? "*Required" : null,
                  decoration: Decorations.createInputDecoration(
                      Icons.cake, "Birthday YYYY-MM-DD"),
                  enabled: _isEnabled ? true : false,
                )),
            Visibility(
              visible: widget.user is Trainer? false : true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Flexible(
                      child: Container(
                        width: 300,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 20, right: 20, bottom: 10),
                            child: TextFormField(
                              initialValue: _height,
                              onSaved: (input) => _height = input,
                              validator: (input) =>
                              input.isEmpty ? "*Required" : null,
                              cursorColor: Decorations.accentColour,
                              decoration:
                              Decorations.createInputDecoration(null, "Height (cm)"),
                              enabled: _isEnabled ? true : false,
                            )),
                      )),
                  new Flexible(
                      child: Container(
                        width: 300,
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 20, right: 20, bottom: 10),
                            child: TextFormField(
                              initialValue: _weight,
                              onSaved: (input) => _weight = input,
                              validator: (input) =>
                              input.isEmpty ? "*Required" : null,
                              cursorColor: Decorations.accentColour,
                              decoration:
                              Decorations.createInputDecoration(null, "Weight (lbs)"),
                              enabled: _isEnabled ? true : false,
                            )),
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: 10.0, left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  initialValue: _fitnessGoal,
                  enabled: _isEnabled ? true : false,
                  maxLines: 2,
                  onSaved: (input) => _fitnessGoal = input,
                  validator: (input) => input.isEmpty ? "*Required" : null,
                  cursorColor: Decorations.accentColour,
                  decoration: Decorations.createInputDecoration(
                      Icons.fitness_center, "Fitness Goal"),
                )),
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
                child: Visibility(
                  visible: _isSaveButtonVisible,
                  child: FlatButton(
                    onPressed: () => _saveProfile(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    splashColor: Colors.deepOrangeAccent,
                    color: Decorations.accentColour,
                    child: Text(
                      "Save",
                      style: Decorations.subtitle,
                    ),
                  ),
                ),
                height: 55,
                width: 150,
              ),
            ),
          ],
        )
    );
  }

  _clearCredentials() {
    clearAll();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (builder) => LoginRegister(),
        )
    );
  }
}
