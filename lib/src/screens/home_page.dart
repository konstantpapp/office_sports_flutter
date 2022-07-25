import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () async {
              FirebaseService service = FirebaseService();
              await service.signOutFromGoogle();
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text("Home"),
      ),
      body: StreamBuilder(
        stream: _playersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['nickname']),
                    subtitle: Text(data['emoji']),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}
