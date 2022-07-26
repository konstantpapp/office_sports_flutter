import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:office_sports_android/src/modals/profile_modal.dart';
import 'package:office_sports_android/src/screens/camera_page.dart';
import 'package:office_sports_android/src/screens/foosball_page.dart';
import 'package:office_sports_android/src/screens/notifications_page.dart';
import 'package:office_sports_android/src/screens/table_tennis_page.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../models/player_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.profileData}) : super(key: key);
  Map<String, dynamic>? profileData;

  static const routeName = '/home';

  @override
  HomePageState createState() => HomePageState(profileData: profileData);
}

class HomePageState extends State<HomePage> {
  HomePageState({this.profileData});
  final _pageViewController = PageController(initialPage: 1);
  int _activePage = 1;
  Map<String, dynamic>? profileData;
  Player? player;
  bool isPlayerFetched = false;

  Future fetchPlayer() async {
    if (profileData != null) {
      player = Player.fromJson(profileData!);
    } else {
      player == null;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: !isPlayerFetched
          ? const Center(child: CircularProgressIndicator())
          : player == null
              ? const ProfileModal()
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
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        width: size.width * 0.7,
        margin: const EdgeInsets.only(bottom: 20.0),
        backgroundColor: const Color.fromARGB(255, 244, 241, 241),
        selectedBackgroundColor: Constants.primarySurfaceColor,
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Constants.primaryColor,
        items: [
          FloatingNavbarItem(icon: Icons.qr_code_scanner),
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
