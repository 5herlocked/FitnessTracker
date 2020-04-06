class Exercise {
  int clientID;
  int trainerID;
  String name;
  String notes;
  bool completed;

  Exercise({this.clientID, this.trainerID, this.name, this.notes, this.completed});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      clientID: json["client_id"],
      trainerID: json["trainer_id"],
      name: json["name"],
      notes: json["notes"],
      completed: json["completed"],
    );
  }
}