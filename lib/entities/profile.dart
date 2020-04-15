class Profile {
  String firstName;
  String lastName;
  String phoneNumber;
  String emergencyPhone;
  String emailID;
  String profilePicture;

  Profile({this.firstName, this.lastName, this.phoneNumber, this.emergencyPhone,
  this.emailID, this.profilePicture});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json["first_name"],
      lastName: json["last_name"],
      phoneNumber: json["phone_number"],
      emergencyPhone: json["emergency_number"],
      emailID: json["email_ID"],
      profilePicture: json["profile_picture"],
    );
  }
}