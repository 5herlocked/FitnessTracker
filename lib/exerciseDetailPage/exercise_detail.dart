import 'package:fitnesstracker/entities/cardio_exercise.dart';
import 'package:fitnesstracker/entities/exercise.dart';
import 'package:fitnesstracker/entities/strength_training_exercise.dart';
import 'package:flutter/material.dart';

import '../decorations.dart';

class ExerciseDetailPage<T extends Exercise> extends StatefulWidget {
  ExerciseDetailPage({Key key, this.exercise}) : super (key: key);
  final T exercise;

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Exercise Details"),
//      ),
//      body: Container (
//        decoration: BoxDecoration(
//          color: Colors.white,
//        ),
//        child: Center(
//          child: FlatButton.icon(
//            onPressed: () => _buttonPressed(context),
//            icon: Icon(Icons.details),
//            label: Text("$exercise"),
//          )
//        ),
//      )
//    );
//  }

//  _buttonPressed(BuildContext context) {
//    return Scaffold.of(context).
//    showSnackBar(SnackBar(
//        content: Text("In $exercise Detail")
//    )
//    );
//  }

  bool isCardioExercise = true;
  String _exerciseName = "", _notes = "";
  int _duration = 0, _distance = 0;
  int _weight = 0;
  int _reps = 0, _sets = 0;

  @override
  void initState() {
    setFormFieldsWithDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.exercise.name,
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

  void setFormFieldsWithDetails() {
    if (widget.exercise is CardioExercise) {
      setState(() {
        isCardioExercise = true;
        CardioExercise cardioExercise = widget.exercise as CardioExercise;
        _exerciseName = cardioExercise.name;
        _notes = cardioExercise.notes;
        _duration = cardioExercise.duration;
        _distance = cardioExercise.distance;
      });
    } else {
      setState(() {
        isCardioExercise = false;
        StrengthTrainingExercise strengthTrainingExercise = widget.exercise as StrengthTrainingExercise;
        _exerciseName = strengthTrainingExercise.name;
        _notes = strengthTrainingExercise.notes;
        _sets = strengthTrainingExercise.sets;
        _reps = strengthTrainingExercise.reps;
        _weight = strengthTrainingExercise.weight;
      });
    }
  }

  // Build the Exercise Form
  Widget _buildForm() {
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return Form(
//          key: _formKey,
//          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                child: isCardioExercise? Text("Exercise Type: Cardio", style: TextStyle(fontSize: 16),):
                Text("Exercise Type: Strength Training", style: TextStyle(fontSize: 16),)
              ),
              Padding(
                  padding:
                  EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    initialValue: _exerciseName,
                    enabled: false,
                    cursorColor: Decorations.accentColour,
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
                                initialValue: _duration.toString(),
                                enabled: false,
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
                                initialValue: _distance.toString(),
                                enabled: false,
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
                                initialValue: _weight.toString(),
                                enabled: false,
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
                                initialValue: _reps.toString(),
                                enabled: false,
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
                    initialValue: _sets.toString(),
                    enabled: false,
                    decoration: Decorations.createInputDecoration(
                        null, "Sets"),
                  ),
                ),
              ),

              Padding(
                padding:
                EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
                child: TextFormField(
                  initialValue: _notes,
                  enabled: false,
                  maxLines: 2,
                  decoration: Decorations.createInputDecoration(
                      null, "Notes"),
                ),
              ),
            ],
          ));
    });
  }

}