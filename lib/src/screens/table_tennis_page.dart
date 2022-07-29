import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:office_sports_android/src/models/player_model.dart';
import 'package:office_sports_android/src/navigation/table_tabs.dart';
import 'package:office_sports_android/src/widgets/profile_picture.dart';
import '../shared/constants.dart';

class TableTennisPage extends StatelessWidget {
  const TableTennisPage({super.key, required this.player});
  final Player player;

  static const routeName = '/tabletennis';

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.1),
              ProfilePicture(player: player, screen: '🏓'),
              SizedBox(height: size.height * 0.05),
              Text(
                player.nickname,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              const Expanded(
                child: TableTabs(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
