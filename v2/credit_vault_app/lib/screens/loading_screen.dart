import 'package:credit_vault_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import '../utils/hex_color.dart';

class LoadingScreen extends StatelessWidget {
  static final String id = "LoadingScreen";
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: WelcomeScreen(),
        title: Text(
          'Daniel Clas | 4A',
          style: TextStyle(fontSize: 40),
        ),
        image: Image(image: AssetImage('images/icon.png')),
        backgroundColor: HexColor('a58faa'),
        photoSize: 40,
        loaderColor: HexColor('a6d6d6'));
  }
}
