import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:users_crud_app/screens/welcome_screen.dart';
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
        image: Image(image: AssetImage('images/ic_launcher.png')),
        backgroundColor: HexColor('2b2e4a'),
        photoSize: 40,
        loaderColor: HexColor('e84545'));
  }
}
