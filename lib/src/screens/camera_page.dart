import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../navigation/screen_tabs.dart';
import '../shared/constants.dart';

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
      setState(() => result = scanData);
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
  }

  // TODO: Register match result on db
  void readQr() async {
    if (result != null) {
      controller!.pauseCamera();
      print(result!.code);
      controller!.dispose();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    readQr();
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
            margin: const EdgeInsets.only(bottom: 20.0),
            child: const Text(
              "If you're the winner of a match, scan\nthe loser's QR code to register the\nmatch result.",
              style: TextStyle(color: Constants.primaryTextColor, fontSize: 16),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ScreenTabs(player: player),
    );
  }
}
