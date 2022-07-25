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
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100,
                    height: 100,
                  ),
                  Positioned(
                    right: 30,
                    top: 0,
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
                      width: 100,
                      height: 100,
                      child: const Text(
                        '🏓',
                        style: TextStyle(fontSize: 50.0),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -20,
                    left: 30,
                    child: Container(
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
                      child: const Text(
                        '⚽️',
                        style: TextStyle(fontSize: 50.0),
                      ),
                    ),
                  ),
                ],
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
