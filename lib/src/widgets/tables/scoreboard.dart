import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/player_model.dart';
import 'package:collection/collection.dart';

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
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: snapshot.data!.docs
                    .mapIndexed((index, DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      Player player = Player.fromJson(data);
                      final stats = widget.sport == 0
                          ? player.foosballStats
                          : player.tableTennisStats;

                      final List<Player?> activePlayers = snapshot.data!.docs
                          .map((doc) {
                            Map<String, dynamic> data =
                                doc.data()! as Map<String, dynamic>;

                            Player player = Player.fromJson(data);
                            final stats = widget.sport == 0
                                ? player.foosballStats
                                : player.tableTennisStats;

                            if (stats!.matchesPlayed != 0) {
                              return player;
                            }
                          })
                          .whereNotNull()
                          .toList()
                          .cast();
                      final int lastIndex = activePlayers.length;
                      final int updatedIndex = activePlayers
                          .indexWhere((el) => el!.nickname == player.nickname);

                      if (stats!.matchesPlayed == 0) {
                        return Container();
                      }
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
                              subtitle: Text('${stats.score} points'),
                              trailing: Text(
                                getPosition(updatedIndex, lastIndex),
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                    .toList()
                    .cast(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: ExpansionTile(
                    title: const Text('Inactive this season'),
                    children: snapshot.data!.docs
                        .mapIndexed((index, DocumentSnapshot document) {
                          final int lastIndex = snapshot.data!.docs.length;
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          Player player = Player.fromJson(data);
                          final stats = widget.sport == 0
                              ? player.foosballStats
                              : player.tableTennisStats;
                          if (stats!.matchesPlayed != 0) {
                            return Container();
                          }
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: const Text('No matches played'),
                                ),
                              ],
                            ),
                          );
                        })
                        .toList()
                        .cast()),
              ),
            ],
          ),
        );
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
