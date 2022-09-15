import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/tables/table_tabs.dart';
import '../models/player_model.dart';
import '../widgets/profile_picture.dart';
import '../widgets/settings/settings.dart';
import '../shared/constants.dart';

class FoosballPage extends StatelessWidget {
  const FoosballPage({super.key, required this.player});
  final Player player;

  static const routeName = '/foosball';

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
              Settings(player: player),
              ProfilePicture(player: player, screen: '⚽️'),
              SizedBox(height: size.height * 0.05),
              Text(
                player.nickname,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TableTabs(sport: 0, player: player),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
