import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../services/firestore_service.dart';
import '../../models/match_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchHistory extends StatefulWidget {
  const MatchHistory({required this.sport, this.teamId});
  final int sport;
  final String? teamId;
  @override
  MatchHistoryState createState() => MatchHistoryState();
}

class MatchHistoryState extends State<MatchHistory> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> matchHistory =
        firestore.getMatchHistory(widget.sport, widget.teamId);
    return StreamBuilder<QuerySnapshot>(
      stream: matchHistory,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  Match match = Match.fromJson(data);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.left,
                          textWidthBasis: TextWidthBasis.parent,
                          softWrap: true,
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '${DateFormat('dd MMMM yyyy @ H:m').format(match.date)}\n',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300)),
                              TextSpan(
                                  text: '${match.winner.nickname} (',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: '+${match.winnerDelta}',
                                  style: const TextStyle(color: Colors.green)),
                              const TextSpan(
                                  text: ')',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const TextSpan(
                                  text: ' won against ',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: '${match.loser.nickname} (',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: '${match.loserDelta}',
                                  style: const TextStyle(color: Colors.red)),
                              const TextSpan(
                                  text: ')\n',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
                .toList()
                .cast(),
          ),
        );
      },
    );
  }
}
