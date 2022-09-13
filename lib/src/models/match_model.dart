import 'package:office_sports_android/src/models/player_model.dart';

class Match {
  late DateTime date;
  late int sport;
  late Player winner;
  late Player loser;
  late int winnerDelta;
  late int loserDelta;
  late String? teamId;

  Match.fromJson(Map<String, dynamic> parsedJson)
      : date = DateTime.parse(parsedJson['date'].toDate().toString()),
        sport = parsedJson['sport'],
        winner = Player.fromJson(parsedJson['winner']),
        loser = Player.fromJson(parsedJson['loser']),
        loserDelta = parsedJson['loserDelta'],
        winnerDelta = parsedJson['winnerDelta'],
        teamId = parsedJson['teamId'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "date": date,
      "sport": sport,
      "winner": winner,
      "loser": loser,
      "winnerDelta": winnerDelta,
      "loserDelta": loserDelta,
      "teamId": teamId
    };
  }
}
