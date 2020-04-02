class ClientProfile {
  int id;
  int trainerId;
  String firstName;
  String lastName;
  String phoneNumber;
  String emergencyPhone;
  String emailID;
  String profilePicture;

  ClientProfile({this.id, this.firstName, this.lastName, this.phoneNumber,
      this.emergencyPhone, this.emailID, this.trainerId, this.profilePicture});

  factory ClientProfile.fromJson(Map<String, dynamic> json) {
    return ClientProfile(
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