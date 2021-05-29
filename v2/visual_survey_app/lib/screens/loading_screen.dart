import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:visual_survey_app/screens/welcome_screen.dart';
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
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        image: Image(image: AssetImage('images/icon.png')),
        backgroundColor: HexColor('323232'),
        photoSize: 40,
        loaderColor: HexColor('14ffec'));
  }
}
