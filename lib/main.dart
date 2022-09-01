import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/services/firestore_service.dart';
import 'src/screens/welcome_page.dart';
import 'src/screens/home_page.dart';
import 'package:flutter/material.dart';

Map<String, dynamic>? profileData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  profileData = await firestore.getPlayerProfile();
  runApp(MyApp(profileData: profileData));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.profileData});
  final Map<String, dynamic>? profileData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Office Sports',
      initialRoute: profileData == null ? '/' : '/home',
      routes: Navigate.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => WelcomePage(),
    '/home': (context) => HomePage(profileData: profileData),
  };
}
