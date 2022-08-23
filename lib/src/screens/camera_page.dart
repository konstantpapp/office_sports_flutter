import 'package:office_sports_android/src/screens/home_page.dart';

import '../models/code_payload_model.dart';
import 'dart:convert';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../shared/constants.dart';
import '../services/firebase_service.dart';
import '../services/firestore_service.dart';
import '../models/match_registration_model.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.player});
  final Player player;

  static const routeName = '/camera';

  @override
  CameraPageState createState() => CameraPageState(player: player);
}

class CameraPageState extends State<CameraPage> {
  CameraPageState({required this.player});
  final Player player;

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      readQr(scanData);
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
  }

  void readQr(Barcode? result) async {
    if (result != null) {
      controller!.pauseCamera();
      final CodePayload payload =
          CodePayload.fromJson(jsonDecode(result.code!));
      final String winnerId = firebase.getUidOrNull()!;
      final MatchRegistration match =
          MatchRegistration(payload.sport, winnerId, payload.userId);
      _showMatchDialog(match, payload);
      controller!.dispose();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _showMatchDialog(
      MatchRegistration registration, CodePayload payload) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register match'),
          content: SingleChildScrollView(
            child: Text(
              'Register a win in ${payload.sport == 0 ? 'foosball ⚽️' : 'table tennis 🏓'} against ${payload.nickname}?',
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final response = firestore.registerMatch(registration);
                ScaffoldMessenger.of(context).showSnackBar(
                  response != null ? snackBarSuccess : snackBarError,
                );
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        profileData: player.toMap(),
                      ),
                    ),
                    (route) => false);
              },
              child: const Text('Register'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: const Color.fromARGB(255, 180, 180, 180),
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 37, 37),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(bottom: 85.0),
            child: const Text(
              "If you're the winner of a match, scan\nthe loser's QR code to register the\nmatch result.",
              style: TextStyle(color: Constants.primaryTextColor, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  final snackBarSuccess = SnackBar(
    content: const Text('Success! Your win has been registered.'),
    backgroundColor: Colors.green,
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  final snackBarError = SnackBar(
    content: const Text('Error! Your win has not been registered.'),
    backgroundColor: Colors.red,
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
