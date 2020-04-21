class Profile with Attributes {
  String firstName;
  String lastName;
  String phoneNumber;
  String emergencyPhone;
  String emailID;
  String profilePicture;
  String password;

  Profile(
      {
        this.firstName, this.lastName,
        this.phoneNumber, this.emergencyPhone,
        this.emailID, this.profilePicture,
        this.password, description,
        birthday, weight,
        height, fitnessGoal
      }
  );
}

class Attributes {
  String description, birthday, weight, height, fitnessGoal;
}