import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';
import '../models/match_registration_model.dart';
import 'package:http/http.dart' as http;

int _maxResultsInScoreboard = 200;
int _maxResultsInRecentMatches = 100;
String _fbCloudFuncBaseUrl =
    "https://us-central1-officesports-5d7ac.cloudfunctions.net";
String _fbCloudFuncRegisterMatchUrl = "/winMatch";

class Firestore {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseService _firebase = FirebaseService();

  Stream<QuerySnapshot> get playersStream =>
      _database.collection('players').snapshots();
  Stream<QuerySnapshot> get _matchesStream =>
      _database.collection('matches').snapshots();
  Stream<QuerySnapshot> get _invitesStream =>
      _database.collection('invites').snapshots();
  Stream<QuerySnapshot> get _seasonsStream =>
      _database.collection('seasons').snapshots();

  void createOrUpdatePlayerProfile(String nickname, String emoji) {
    var uid = _firebase.getUidOrNull();
    if (uid == null) return;

    _database
        .collection('players')
        .doc(uid)
        .set({'nickname': nickname, 'emoji': emoji}, SetOptions(merge: true))
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<Map<String, dynamic>?> getPlayerProfile() async {
    var uid = _firebase.getUidOrNull();
    try {
      final result = await _database.collection('players').doc(uid).get();
      return result.data();
    } catch (err) {
      return null;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatchHistory(int sport) {
    return _database
        .collection('matches')
        .where('sport', isEqualTo: sport)
        .orderBy('date', descending: true)
        .limit(_maxResultsInRecentMatches)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getScoreboard(int sport) {
    final String fieldPath =
        sport == 0 ? "foosballStats.score" : "tableTennisStats.score";
    return _database
        .collection('players')
        .orderBy(fieldPath, descending: true)
        .limit(_maxResultsInScoreboard)
        .snapshots();
  }

  Future<http.Response?>? registerMatch(MatchRegistration registration) async {
    if (registration.winnerId == registration.loserId) {
      return null;
    }

    final response = await http.post(
      Uri.parse("$_fbCloudFuncBaseUrl/$_fbCloudFuncRegisterMatchUrl"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(registration.toMap()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return null;
    } else {
      throw Exception('Failed to register match');
    }
  }
}

Firestore firestore = Firestore();
