import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Relevamiento Visual',
        theme: ThemeData.light(),
        home: SplashScreen(
          seconds: 3,
          gradientBackground: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xff2196f3), Color(0xffe8e8e8)]),
          loadingText: Text(
            "Daniel Clas - Tabla didáctica",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          styleTextUnderTheLoader: TextStyle(fontSize: 30),
          loaderColor: Color(0xffe8e8e8),
          navigateAfterSeconds: LoginPage(),
        )
        //home: LoginPage(),
        );
  }
}
