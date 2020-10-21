import 'package:aulas_chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ).copyWith(hintColor: Colors.teal[300]),
        home: SplashScreen(
          seconds: 3,
          gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff8bc147), Color(0xffe8e8e8)]),
          loadingText: Text(
            "Daniel Clas - Aulas chat",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          styleTextUnderTheLoader: TextStyle(fontSize: 30),
          loaderColor: Color(0xffe8e8e8),
          navigateAfterSeconds: LoginPage(),
        ));
  }
}
