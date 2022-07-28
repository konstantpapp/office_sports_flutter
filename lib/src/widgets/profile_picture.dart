import 'package:flutter/material.dart';
import 'package:office_sports_android/src/widgets/qr_code.dart';
import '../models/player_model.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, required this.player, this.screen});
  final Player player;
  final String? screen;

  @override
  Widget build(context) {
    return screen != null
        ? GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return QRCode(
                      nickname: player.nickname,
                      screen: screen!,
                    );
                  });
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                    border: Border.all(
                      width: 5,
                      color: Colors.white,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  child: Text(
                    player.emoji,
                    style: const TextStyle(fontSize: 60.0),
                  ),
                ),
                Positioned(
                  left: 60,
                  top: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.teal,
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    child: Text(
                      screen!,
                      style: const TextStyle(fontSize: 25.0),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange,
              border: Border.all(
                width: 5,
                color: Colors.white,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
            alignment: Alignment.center,
            width: 100,
            height: 100,
            child: Text(
              player.emoji,
              style: const TextStyle(fontSize: 60.0),
            ),
          );
  }
}
