import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:office_sports_android/src/models/player_model.dart';
import 'package:office_sports_android/src/models/screen_arguments.dart';
import 'package:office_sports_android/src/screens/foosball_page.dart';
import 'package:office_sports_android/src/screens/notifications_page.dart';
import 'package:office_sports_android/src/screens/table_tennis_page.dart';
import 'package:office_sports_android/src/shared/constants.dart';

class ScreenTabs extends StatefulWidget {
  const ScreenTabs({required this.player});
  final Player player;
  @override
  createState() {
    return ScreenTabsState(player: player);
  }
}

class ScreenTabsState extends State<ScreenTabs> {
  ScreenTabsState({required this.player});
  final Player player;
  static int _screenIndex = 1;

  Map<int, String> tabScreens = {
    0: '/camera',
    1: TableTennisPage.routeName,
    2: FoosballPage.routeName,
    3: NotificationsPage.routeName
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    return FloatingNavbar(
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
      currentIndex: _screenIndex,
      onTap: (int value) {
        setState(() {
          _screenIndex = value;
          Navigator.pushReplacementNamed(context, tabScreens[_screenIndex]!,
              arguments: ScreenArguments(player));
        });
      },
    );
  }
}
