import 'player_model.dart';

class SeasonStats {
  late DateTime date;
  late Player winner;
  late int sport;

  SeasonStats.fromJson(Map<String, dynamic> parsedJson)
      : date = DateTime.parse(parsedJson['date'].toDate().toString()),
        sport = parsedJson['sport'],
        winner = Player.fromJson(parsedJson['winner']);
}
