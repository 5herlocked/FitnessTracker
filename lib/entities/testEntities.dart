import 'package:fitnesstracker/entities/exercise.dart';

import 'client.dart';
import 'trainer.dart';
import 'cardio_exercise.dart';
import 'strength_training_exercise.dart';
class TestEntities {
  static Client testClient = Client(
    firstName: "Robert",
    lastName: "Stonks",
    fullName: "Robert Stonks",
    email: "rstonks@gmail.com",
    clientID: 1,
    trainerID: 5,
    phoneNumber: "9999999999",
    password: "thisshan'tbewritten",
  );

  static Trainer testTrainer = Trainer(
    firstName: "Christopher",
    lastName: "Levinsky",
    fullName: "Christopher Levinsky",
    email: "clevinsky@goldgym.org",
    trainerID: 4,
    trainerMembershipID: 5,
    phoneNumber: "7777777777",
    password: "thisshallbewrittennary",
  );

  static List<Client> testClientList = <Client> [
    Client(
        clientID:5,
        email:"someemail@gmail.com",
        firstName:"Billy",
        lastName: "Joe",
        phoneNumber:"1234567890",
        password:"joeBilly420",
        trainerID: 5,
    ),
    Client(
        clientID:11,
        email: "testemail2@gmail.com",
        firstName: "billy",
        lastName: "joe",
        phoneNumber: "1234567890",
        password: "password",
        trainerID: 5,
    ),
    Client(
        clientID:17,
        email:"bluejay28@gmail.com",
        firstName:"Blue",
        lastName:"Jay",
        phoneNumber:"7708888888",
        password:"blue28",
        trainerID: 5,
    ),
  ];

  static List<Exercise> testExerciseList = <Exercise> [
    // TODO fill this out please please please
    CardioExercise(

    ),
    CardioExercise(

    ),
    StrengthTrainingExercise(

    ),
    StrengthTrainingExercise(

    ),
    StrengthTrainingExercise(

    ),
    CardioExercise(

    ),
  ];
}