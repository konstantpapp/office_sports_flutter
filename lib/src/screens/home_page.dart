import 'package:firebase_auth/firebase_auth.dart';
import 'package:office_sports_android/src/screens/table_tennis_page.dart';
import '../services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../modals/profile_modal.dart';
import '../shared/constants.dart';
import '../models/player_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _playersStream =
      FirebaseFirestore.instance.collection('playerprofiles').snapshots();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // appBar: AppBar(
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(
        //         Icons.logout,
        //         color: Colors.black,
        //       ),
        //       onPressed: () async {
        //         FirebaseService service = FirebaseService();
        //         await service.signOutFromGoogle();
        //         Navigator.pushReplacementNamed(context, '/');
        //       },
        //     )
        //   ],
        //   systemOverlayStyle: SystemUiOverlayStyle.dark,
        //   title: const Text("Home"),
        // ),
        backgroundColor: Constants.backgroundColor,
        body: FutureBuilder(
          future: firestore.getPlayerProfile(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null) {
              return ProfileModal();
            }
            return TableTennisPage(player: Player.fromJson(snapshot.data));
          },
        ),
      ),
    );
  }
}
