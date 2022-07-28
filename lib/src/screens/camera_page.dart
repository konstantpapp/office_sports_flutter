import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../navigation/screen_tabs.dart';
import '../shared/constants.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, required this.player, required this.camera});
  final Player player;
  final CameraDescription camera;

  static const routeName = '/camera';

  @override
  CameraPageState createState() => CameraPageState(player: player);
}

class CameraPageState extends State<CameraPage> {
  CameraPageState({required this.player});
  final Player player;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRect(
                    child: Transform.scale(
                      scale: _controller.value.aspectRatio,
                      child: Center(
                        child: CameraPreview(_controller),
                      ),
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
                      style: TextStyle(
                          color: Constants.primaryTextColor, fontSize: 16),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        bottomNavigationBar: ScreenTabs(player: player));
  }
}
