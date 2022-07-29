import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:office_sports_android/src/modals/profile_modal.dart';
import 'package:office_sports_android/src/screens/camera_page.dart';
import 'package:office_sports_android/src/screens/foosball_page.dart';
import 'package:office_sports_android/src/screens/notifications_page.dart';
import 'package:office_sports_android/src/screens/table_tennis_page.dart';
import '../services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  int _activePage = 1;
  final _pageViewController = PageController(initialPage: 1);
  Player? player;
  bool isPlayerFetched = false;

  Future fetchPlayer() async {
    Map<String, dynamic>? data = await firestore.getPlayerProfile();
    if (data != null) {
      player = Player.fromJson(data);
    }
    setState(() {
      isPlayerFetched = true;
    });
  }

  @override
  void initState() {
    fetchPlayer();
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: !isPlayerFetched
          ? const Center(child: CircularProgressIndicator())
          : player == null
              ? ProfileModal()
              : PageView(
                  controller: _pageViewController,
                  children: [
                    CameraPage(player: player!),
                    TableTennisPage(player: player!),
                    FoosballPage(player: player!),
                    NotificationsPage(player: player!),
                  ],
                  onPageChanged: (index) {
                    setState(() {
                      _activePage = index;
                    });
                  },
                ),
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Colors.white,
        selectedBackgroundColor: Constants.primarySurfaceColor,
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Constants.primaryColor,
        items: [
          FloatingNavbarItem(icon: Icons.qr_code),
          FloatingNavbarItem(icon: Icons.sports_tennis),
          FloatingNavbarItem(icon: Icons.sports_soccer),
          FloatingNavbarItem(icon: Icons.notifications),
        ],
        currentIndex: _activePage,
        onTap: (int index) {
          _pageViewController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.bounceOut);
        },
      ),
    );
  }
}
