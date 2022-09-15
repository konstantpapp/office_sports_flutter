import '../services/firebase_service.dart';
import '../services/firestore_service.dart';
import '../screens/home_page.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  _GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? SizedBox(
            width: size.width * 0.8,
            child: OutlinedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                FirebaseService service = FirebaseService();
                await service.signInwithGoogle();
                final profileData = await firestore.getPlayerProfile();
                if (profileData == null) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          profileData: profileData,
                        ),
                      ),
                      (route) => false);
                }
                setState(() {
                  isLoading = false;
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
              child: const Text(
                'Sign in with Google',
                style: TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
          )
        : const CircularProgressIndicator();
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
