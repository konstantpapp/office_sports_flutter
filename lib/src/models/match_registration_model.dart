class MatchRegistration {
  final int sport;
  final String winnerId;
  final String loserId;

  MatchRegistration(this.sport, this.winnerId, this.loserId);

  MatchRegistration.fromJson(Map<String, dynamic> parsedJson)
      : sport = parsedJson['sport'],
        winnerId = parsedJson['winnerId'],
        loserId = parsedJson['loserId'];

  Map<String, dynamic> toMap() {
    return {
      "sport": sport,
      "winnerId": winnerId,
      "loserId": loserId,
    };
  }
}
