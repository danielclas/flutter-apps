import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/svg.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController ctrl;
  Animation animation;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation =
        ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(ctrl);
    ctrl.forward();
    ctrl.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: SvgPicture.asset(
                        'images/main-graphic.svg',
                        semanticsLabel: 'Main Graphic',
                        height: 300.0,
                        width: 200.0,
                      ),
                      height: 60,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                text: 'Ingresar',
                onPressed: () {
                  //Go to login screen.
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                color: Colors.lightBlueAccent),
            RoundedButton(
              text: 'Registrarse',
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
