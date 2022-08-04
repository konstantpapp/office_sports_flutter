import 'package:office_sports_android/src/models/player_model.dart';

class Match {
  late DateTime date;
  late String sport;
  late Player winner;
  late Player loser;
  late int loserDelta;
  late int winnerDelta;

  Match.fromJson(Map<String, dynamic> parsedJson)
      : date = DateTime.parse(parsedJson['date'].toDate().toString()),
        sport = parsedJson['sport'],
        winner = Player.fromJson(parsedJson['winner']),
        loser = Player.fromJson(parsedJson['loser']),
        loserDelta = parsedJson['loserDelta'],
        winnerDelta = parsedJson['winnerDelta'];
}
