import 'stats_model.dart';

class Player {
  late String nickname;
  late String emoji;
  late Stats? foosballStats;
  late Stats? tableTennisStats;

  Player(
    this.nickname,
    this.emoji, [
    this.foosballStats,
    this.tableTennisStats,
  ]);

  Player.fromJson(Map<String, dynamic> parsedJson)
      : nickname = parsedJson['nickname'],
        emoji = parsedJson['emoji'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "nickname": nickname,
      "emoji": emoji,
    };
  }
}
