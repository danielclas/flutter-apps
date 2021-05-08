import 'package:credit_vault_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: WelcomeScreen.id,
        routes: {WelcomeScreen.id: (context) => WelcomeScreen(), HomeScreen.id: (context) => HomeScreen()},
        debugShowCheckedModeBanner: false);
  }
}
