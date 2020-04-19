import 'package:fitnesstracker/entities/cardio_exercise.dart';
import 'package:fitnesstracker/entities/profile.dart';
import 'package:fitnesstracker/entities/strength_training_exercise.dart';
import 'package:flutter/material.dart';
import '../decorations.dart';

enum ExerciseType {Cardio, StrengthTraining}

class AssignExercisePage<T extends Profile> extends StatefulWidget {
  final T user;
  AssignExercisePage({Key key, this.user}) : super(key: key);

  @override
  _AssignExercisePageState createState() => _AssignExercisePageState();
}

class _AssignExercisePageState extends State<AssignExercisePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ExerciseType exerciseType = ExerciseType.Cardio;
  bool isCardioExercise = true;

  String _exerciseName, _notes;
  int _duration, _distance;
  double _weight;
  int _reps, _sets;

  bool _loading = false;
  bool _autoValidate = false;
  String errorMsg = "";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Assign an Exercise",
            style: TextStyle(fontFamily: 'Raleway'),
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  _buildForm()
                ],
              ),
            )),
    );
  }

  void _addExercise() async {
    final FormState form = _formKey.currentState;
    form.save();

    CardioExercise cardioExercise = new CardioExercise();
    StrengthTrainingExercise strengthTrainingExercise = new StrengthTrainingExercise();
    int statusCode;

    if (isCardioExercise) {
//      cardioExercise.trainerID = ;
//      cardioExercise.clientID = ;
      cardioExercise.name = _exerciseName;
      cardioExercise.distance = _distance;
      cardioExercise.duration = _duration;
      cardioExercise.notes = _notes;

      // Call the API to assign this exercise to the client
      //statusCode = await  cardioExercise.assignCardioExercise();

    } else {
//      strengthTrainingExercise.trainerID = ;
//      strengthTrainingExercise.clientID = ;
      strengthTrainingExercise.weight = _weight;
      strengthTrainingExercise.reps = _reps;
      strengthTrainingExercise.sets = _sets;
      strengthTrainingExercise.name = _exerciseName;
      strengthTrainingExercise.notes = _notes;

      // Call the API to assign this exercise to the client
      //statusCode = await  strengthTrainingExercise.assignStrengthExercise();
    }

    // Call the API to update the client's profile in the database
    //clientUser = await clientUser.updateClientProfile();
    statusCode = 200;
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
              title: new Text("Exercise Error"),
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
                      _loading = false;
                    });
                  },
                ),
              ],
            );
          });
    } else {
      setState(() {
        _loading = false;
        Navigator.of(context).pop();
      });
    }
  }

  // Build the Exercise Form
  _buildForm() {
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                child: Text("Exercise Type", style: TextStyle(fontSize: 16),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: ExerciseType.Cardio,
                    groupValue: exerciseType,
                    autofocus: true,
                    activeColor: Decorations.accentColour,
                    onChanged: (ExerciseType value) {
                      state(() {
                        isCardioExercise = true;
                        exerciseType = value;
                      });
                    },
                  ),
                  Text('Cardio', style: Decorations.radioButtonLabel),
                  Radio(
                    value: ExerciseType.StrengthTraining,
                    groupValue: exerciseType,
                    autofocus: true,
                    activeColor: Decorations.accentColour,
                    onChanged: (ExerciseType value) {
                      state(() {
                        isCardioExercise = false;
                        exerciseType = value;
                      });
                    },
                  ),
                  Text('Strength Training', style: Decorations.radioButtonLabel),
                ],
              ),
              Padding(
                  padding:
                  EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    onSaved: (input) => _exerciseName = input,
                    cursorColor: Decorations.accentColour,
                    validator: (input) => input.isEmpty ? "*Required" : null,
                    decoration: Decorations.createInputDecoration(
                        null, "Exercise Name"),
                  )),
              Visibility(
                visible: isCardioExercise,
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
                                onSaved: (input) => _duration = int.parse(input),
                                validator: (input) =>
                                input.isEmpty ? "*Required" : null,
                                cursorColor: Decorations.accentColour,
                                decoration:
                                Decorations.createInputDecoration(null, "Duration"),
                              )
                          ),
                        )),
                    new Flexible(
                        child: Container(
                          width: 300,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, left: 20, right: 20, bottom: 10),
                              child: TextFormField(
                                onSaved: (input) => _distance = int.parse(input),
                                validator: (input) =>
                                input.isEmpty ? "*Required" : null,
                                cursorColor: Decorations.accentColour,
                                decoration:
                                Decorations.createInputDecoration(null, "Distance"),
                              )
                          ),
                        )),
                  ],
                ),
              ),
              Visibility(
                visible: !isCardioExercise,
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
                                onSaved: (input) => _weight = double.parse(input),
                                validator: (input) =>
                                input.isEmpty ? "*Required" : null,
                                cursorColor: Decorations.accentColour,
                                decoration:
                                Decorations.createInputDecoration(null, "Weight"),
                              )
                          ),
                        )),
                    new Flexible(
                        child: Container(
                          width: 300,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.0, left: 20, right: 20, bottom: 10),
                              child: TextFormField(
                                onSaved: (input) => _reps = int.parse(input),
                                validator: (input) =>
                                input.isEmpty ? "*Required" : null,
                                cursorColor: Decorations.accentColour,
                                decoration:
                                Decorations.createInputDecoration(null, "Reps"),
                              )
                          ),
                        )),
                  ],
                ),
              ),
              Visibility(
                visible: !isCardioExercise,
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    onSaved: (input) => _sets = int.parse(input),
                    cursorColor: Decorations.accentColour,
                    validator: (input) => input.isEmpty ? "*Required" : null,
                    decoration: Decorations.createInputDecoration(
                        null, "Sets"),
                  ),
                ),
              ),

              Padding(
                padding:
                EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                child: TextFormField(
                  onSaved: (input) => _notes = input,
                  cursorColor: Decorations.accentColour,
                  validator: (input) => input.isEmpty ? "*Required" : null,
                  maxLines: 2,
                  decoration: Decorations.createInputDecoration(
                      null, "Notes"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: _loading == true
                    ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Decorations.accentColour),
                )
                    : Container(
                  child: FlatButton(
                    onPressed: () => _addExercise(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    splashColor: Colors.deepOrangeAccent,
                    color: Decorations.accentColour,
                    child: Text(
                      "Assign",
                      style: Decorations.loginRegButton,
                    ),
                  ),
                  height: 55,
                  width: 150,
                ),
              ),
            ],
          ));
    });
  }
}