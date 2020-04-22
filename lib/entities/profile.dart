class Profile {
  String firstName;
  String lastName;
  String phoneNumber;
  String emergencyPhone;
  String emailID;
  String profilePicture;
  String password;
  Attributes profileAttributes;

  Profile(
      {
        this.firstName, this.lastName,
        this.phoneNumber, this.emergencyPhone,
        this.emailID, this.profilePicture,
        this.password, this.profileAttributes,
      }
      );
}

class Attributes {
  String description, birthday,fitnessGoal;
  int weight, height;

  Attributes(
      {
        this.description,
        this.birthday,
        this.weight,
        this.height,
        this.fitnessGoal
      }
      );

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      description: json['bio'],
      birthday: json['dob'],
      weight: json['weight'],
      height: json['height'],
      fitnessGoal: json['goal'],
    );
  }
}