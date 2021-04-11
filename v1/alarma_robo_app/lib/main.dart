import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/login_screen.dart';
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
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ).copyWith(
            hintColor: Colors.red[500],
            highlightColor: Colors.red[500],
            accentColor: Colors.red[500]),
        home: SplashScreen(
          seconds: 3,
          gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xffed5957), Color(0xff727272)]),
          loadingText: Text(
            "Daniel Clas - Alarma robos",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          styleTextUnderTheLoader: TextStyle(fontSize: 30),
          loaderColor: Color(0xffe8e8e8),
          navigateAfterSeconds: LoginPage(),
        ));
  }
}
