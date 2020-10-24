import './screens/login_screen.dart';
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
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ).copyWith(hintColor: Colors.grey, accentColor: Colors.grey),
        home: SplashScreen(
          seconds: 3,
          gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.orange[200], Color(0xffcbcdd9)]),
          loadingText: Text(
            "Daniel Clas - Administración de usuarios",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          styleTextUnderTheLoader: TextStyle(fontSize: 30),
          loaderColor: Color(0xffe8e8e8),
          navigateAfterSeconds: LoginPage(),
        ));
  }
}
