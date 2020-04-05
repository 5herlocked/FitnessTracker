class Exercise {
  int clientID;
  int trainerID;
  String notes;
  bool completed;

  Exercise({this.clientID, this.trainerID, this.notes, this.completed});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      clientID: json["client_id"],
      trainerID: json["trainer_id"],
      notes: json["notes"],
      completed: json["completed"],
    );
  }
}