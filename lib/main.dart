import 'package:firebase_core/firebase_core.dart';
import 'src/services/firestore_service.dart';
import 'package:office_sports_android/src/models/screen_arguments.dart';
import 'package:office_sports_android/src/screens/camera_page.dart';
import 'package:office_sports_android/src/screens/foosball_page.dart';
import 'package:office_sports_android/src/screens/notifications_page.dart';
import 'package:office_sports_android/src/screens/table_tennis_page.dart';
import 'src/screens/welcome_page.dart';
import 'src/screens/home_page.dart';
import 'package:flutter/material.dart';

Map<String, dynamic>? profileData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  profileData = await firestore.getPlayerProfile();
  runApp(MyApp(profileData: profileData));
}

class MyApp extends StatelessWidget {
  const MyApp({this.profileData});
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
      onGenerateRoute: (settings) {
        final args = settings.arguments as ScreenArguments;
        if (settings.name == HomePage.routeName) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) {
            return HomePage(profileData: profileData);
          });
        } else if (settings.name == CameraPage.routeName) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) {
            return CameraPage(player: args.player);
          });
        } else if (settings.name == TableTennisPage.routeName) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) {
            return TableTennisPage(player: args.player);
          });
        } else if (settings.name == FoosballPage.routeName) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) {
            return FoosballPage(player: args.player);
          });
        } else if (settings.name == NotificationsPage.routeName) {
          return PageRouteBuilder(pageBuilder: (_, __, ___) {
            return NotificationsPage(player: args.player);
          });
        }
        return null;
      },
    );
  }
}

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => WelcomePage(),
    '/home': (context) => HomePage(profileData: profileData),
  };
}
