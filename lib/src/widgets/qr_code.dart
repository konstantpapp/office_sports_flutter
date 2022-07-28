import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCode extends StatelessWidget {
  const QRCode({required this.nickname, required this.screen});

  final String screen;
  final String nickname;

  @override
  Widget build(context) {
    final String sport = screen == '🏓' ? 'tabletennis' : 'soccer';
    return Center(
      child: QrImage(
        data: 'Won $nickname in $sport',
        version: QrVersions.auto,
        gapless: false,
        size: 200,
        embeddedImage: AssetImage('assets/${sport}_emoji.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: const Size(40, 40),
        ),
      ),
    );
  }
}
