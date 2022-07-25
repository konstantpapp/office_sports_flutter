import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? result = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Welcome to\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),
                    TextSpan(
                        text: ' Office Sports!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0)),
                    TextSpan(
                        text: ' 😎',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0)),
                  ])),
              SizedBox(height: size.height * 0.1),
              const Text(
                '🏓 - ⚽️',
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(height: size.height * 0.1),
              SizedBox(
                width: size.width * 0.7,
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                  child: const Text(
                    'Sign in with Google',
                    style: TextStyle(color: Constants.primaryColor),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData ? "Version ${snapshot.data!.version}" : "",
                    style: const TextStyle(color: Colors.grey),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
