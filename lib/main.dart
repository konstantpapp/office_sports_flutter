import 'package:firebase_core/firebase_core.dart';
import 'package:office_sports_android/src/models/screen_arguments.dart';
import 'package:office_sports_android/src/screens/foosball_page.dart';
import 'package:office_sports_android/src/screens/notifications_page.dart';
import 'package:office_sports_android/src/screens/table_tennis_page.dart';
import 'src/screens/welcome_page.dart';
import 'src/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Office Sports',
      initialRoute: '/',
      routes: Navigate.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == TableTennisPage.routeName) {
          final args = settings.arguments as ScreenArguments;
          return PageRouteBuilder(pageBuilder: (_, __, ___) {
            return TableTennisPage(player: args.player);
          });
        } else if (settings.name == FoosballPage.routeName) {
          final args = settings.arguments as ScreenArguments;
          return PageRouteBuilder(pageBuilder: (_, __, ___) {
            return FoosballPage(player: args.player);
          });
        } else if (settings.name == NotificationsPage.routeName) {
          final args = settings.arguments as ScreenArguments;
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
    '/home': (context) => const HomePage(),
  };
}
