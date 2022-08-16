import 'package:flutter/material.dart';
import '../../services/firebase_service.dart';

class SignOutDialog extends StatelessWidget {
  @override
  Widget build(context) {
    return AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final navigator = Navigator.of(context);
            await firebase.signOutFromGoogle();
            navigator.pushNamedAndRemoveUntil('/', (route) => false);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
