import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/player_model.dart';
import '../widgets/profile_picture.dart';
import '../widgets/settings/settings.dart';
import '../shared/constants.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key, required this.player});
  final Player player;

  static const routeName = '/notifications';

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
              ProfilePicture(player: player),
              SizedBox(height: size.height * 0.05),
              Text(
                player.nickname,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.15),
              const Text(
                'Your match invitations will show\nup here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
