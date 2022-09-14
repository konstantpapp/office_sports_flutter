import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:office_sports_android/src/models/season_stats_model.dart';
import '../../shared/constants.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import '../../services/firestore_service.dart';
import 'package:intl/intl.dart';

const List<String> sports = <String>['Table Tennis', 'Foosball', 'Pool'];

class SeasonResults extends StatefulWidget {
  @override
  SeasonResultsState createState() => SeasonResultsState();
}

class SeasonResultsState extends State<SeasonResults> {
  late ConfettiController _confettiController;
  String dropdownValue = sports.first;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(days: 365),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _confettiController.dispose();
  }

  @override
  Widget build(context) {
    final Stream<QuerySnapshot> seasonResults = firestore.getSeasonStats();
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Constants.secondaryColor,
      height: size.height * 0.9,
      child: Stack(
        children: [
          buildConfettiWidget(_confettiController, pi / 4),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.1),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                    border: Border.all(
                      width: 5,
                      color: Colors.white,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  child: const Text(
                    '🏆',
                    style: TextStyle(fontSize: 50.0),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                const Text(
                  'Season results!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Whoever has the most points at the end of a given month is considered the winner of that season. Good luck! 🤩',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                DropdownButton(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward_rounded),
                  elevation: 16,
                  style: const TextStyle(color: Constants.secondaryTextColor),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: sports.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: seasonResults,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 200.0,
                        child: ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          SeasonStats season = SeasonStats.fromJson(data);
                          return Card(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Text(
                                  season.winner.emoji,
                                  style: const TextStyle(fontSize: 40),
                                ),
                                title: Text(
                                  '${season.winner.nickname} 👑',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(DateFormat('MMMM yyyy')
                                    .format(season.date)),
                                trailing: const Text(
                                  '🏖',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ));
                        }).toList()),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align buildConfettiWidget(controller, double blastDirection) {
    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: controller,
        blastDirectionality: BlastDirectionality.explosive,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ],
      ),
    );
  }
}
