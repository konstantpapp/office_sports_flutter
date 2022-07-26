import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

class Firestore {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseService _firebase = FirebaseService();

  Stream<QuerySnapshot> get _playersStream =>
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

  Map<String, dynamic>? getPlayerProfile() {
    var uid = _firebase.getUidOrNull();
    if (uid == null) return null;

    _database.collection('players').doc(uid).get().then(
      (DocumentSnapshot doc) {
        return doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print('Error getting document: $e'),
    );
    return null;
  }
}
