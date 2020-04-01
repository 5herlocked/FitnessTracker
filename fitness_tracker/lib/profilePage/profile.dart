class Profile {
  int id;
  int trainerId;
  String firstName;
  String lastName;
  String phoneNumber;
  String emergencyPhone;
  String emailID;
  String profilePicture;

  Profile({this.id, this.firstName, this.lastName, this.phoneNumber,
      this.emergencyPhone, this.emailID, this.trainerId, this.profilePicture});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      emergencyPhone: json['emergencyPhone'],
      emailID: json['emailId'],
      trainerId: json['trainerid'],
      profilePicture: json['profilePicture'],
    );
  }
}