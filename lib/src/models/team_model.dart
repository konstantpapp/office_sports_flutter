class Team {
  String name;
  String? id;

  Team(this.name, [this.id]);

  Team.fromJson(Map<String, dynamic> parsedJson)
      : name = parsedJson['name'],
        id = parsedJson['id'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "id": id,
    };
  }
}
