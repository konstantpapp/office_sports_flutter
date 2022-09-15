import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/player_model.dart';

class Scoreboard extends StatefulWidget {
  const Scoreboard({required this.sport, this.teamId});
  final int sport;
  final String? teamId;
  @override
  ScoreboardState createState() => ScoreboardState();
}

class ScoreboardState extends State<Scoreboard> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> scoreboard =
        firestore.getScoreboard(widget.sport, widget.teamId);
    return StreamBuilder<QuerySnapshot>(
      stream: scoreboard,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
            children: snapshot.data!.docs
                .mapIndexed((index, DocumentSnapshot document) {
                  final int lastIndex = snapshot.data!.docs.length;
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  Player player = Player.fromJson(data);
                  final stats = widget.sport == 0
                      ? player.foosballStats
                      : player.tableTennisStats;
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            player.emoji,
                            style: const TextStyle(fontSize: 40),
                          ),
                          title: Text(
                            player.nickname,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('${stats?.score} points'),
                          trailing: Text(
                            getPosition(index, lastIndex),
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  );
                })
                .toList()
                .cast());
      },
    );
  }

  String getPosition(int index, int lastIndex) {
    if (index + 1 == lastIndex) {
      return '💩';
    }
    switch (index) {
      case 0:
        return '🥇';
      case 1:
        return '🥈';
      case 2:
        return '🥉';
      default:
        return '${index + 1}th';
    }
  }
}
