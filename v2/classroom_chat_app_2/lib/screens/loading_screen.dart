import 'package:flash_chat/screens/welcome_screen.dart';
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
        backgroundColor: HexColor('28b5b5'),
        photoSize: 40,
        loaderColor: HexColor('d2e69c'));
  }
}
