import 'package:flutter/material.dart';
import 'package:theft_alarm_app/screens/home_screen.dart';
import 'package:theft_alarm_app/screens/loading_screen.dart';
import 'package:theft_alarm_app/screens/welcome_screen.dart';
import 'package:theft_alarm_app/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: LoadingScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          LoadingScreen.id: (context) => LoadingScreen()
        },
        debugShowCheckedModeBanner: false);
  }
}
