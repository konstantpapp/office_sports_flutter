class Stats {
  final int sport;
  final int score;
  final int matchesPlayed;
  final int? seasonWins;

  Stats(this.sport, this.score, this.matchesPlayed, this.seasonWins);

  Stats.fromJson(Map<String, dynamic> parsedJson)
      : sport = parsedJson['sport'],
        score = parsedJson['score'],
        matchesPlayed = parsedJson['matchesPlayed'],
        seasonWins = parsedJson['seasonWins'];
}
