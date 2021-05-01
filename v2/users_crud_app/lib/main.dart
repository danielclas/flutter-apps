import 'package:flutter/material.dart';
import 'package:users_crud_app/screens/home_screen.dart';
import 'package:users_crud_app/screens/welcome_screen.dart';
import 'package:users_crud_app/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: HomeScreen.id,
        routes: {WelcomeScreen.id: (context) => WelcomeScreen(), HomeScreen.id: (context) => HomeScreen()},
        debugShowCheckedModeBanner: false);
  }
}
