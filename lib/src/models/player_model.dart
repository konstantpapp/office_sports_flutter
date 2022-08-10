import 'stats_model.dart';

class Player {
  final String nickname;
  final String emoji;
  final Stats? foosballStats;
  final Stats? tableTennisStats;

  Player(
    this.nickname,
    this.emoji, [
    this.foosballStats,
    this.tableTennisStats,
  ]);

  Stats? statsForSport(int sport) {
    return sport == 0 ? foosballStats : tableTennisStats;
  }

  int? scoreForSport(int sport) {
    return statsForSport(sport)?.score;
  }

  Player.fromJson(Map<String, dynamic> parsedJson)
      : nickname = parsedJson['nickname'],
        emoji = parsedJson['emoji'],
        foosballStats = parsedJson['foosballStats'] != null
            ? Stats.fromJson(parsedJson['foosballStats'])
            : null,
        tableTennisStats = parsedJson['tableTennisStats'] != null
            ? Stats.fromJson(parsedJson['tableTennisStats'])
            : null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "nickname": nickname,
      "emoji": emoji,
      "foosballStats": foosballStats,
      "tableTennisStats": tableTennisStats
    };
  }
}
