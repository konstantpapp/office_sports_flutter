import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import '../models/code_payload_model.dart';
import '../services/firebase_service.dart';

class QRCode extends StatelessWidget {
  const QRCode({required this.nickname, required this.screen});

  final String screen;
  final String nickname;

  @override
  Widget build(context) {
    final String loserId = firebase.getUidOrNull()!;
    final int sport = screen == '🏓' ? 1 : 0;
    final CodePayload payload = CodePayload(loserId, nickname, sport);
    return Center(
      child: QrImage(
        // data: 'Won $nickname in $sport',
        data: jsonEncode(payload.toMap()),
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
