import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

int _maxResultsInScoreboard = 200;
int _maxResultsInRecentMatches = 100;

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
        .set({'nickname': nickname, 'emoji': emoji})
        .then((value) => print('User added'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  Future<Map<String, dynamic>?> getPlayerProfile() async {
    var uid = _firebase.getUidOrNull();
    final result = await _database.collection('players').doc(uid).get();
    return result.data();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatchHistory(int sport) {
    return _database
        .collection('matches')
        .where('sport', isEqualTo: sport)
        .orderBy('date', descending: true)
        .limit(_maxResultsInRecentMatches)
        .snapshots();
  }
}

Firestore firestore = Firestore();
