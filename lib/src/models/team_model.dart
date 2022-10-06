class Team {
  String? id;
  String name;

  Team(this.name, [this.id]);

  Team.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] ?? null,
        name = parsedJson['name'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
    };
  }
}
