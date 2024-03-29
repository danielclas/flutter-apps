import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:users_crud_app/components/login_register_component.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnimatedBackground(
          behaviour: RacingLinesBehaviour(
            numLines: 10,
          ),
          vsync: this,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Bienvenid@',
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  'Completá tus datos para ingresar',
                  style: TextStyle(fontSize: 20),
                ),
                LoginRegisterComponent()
              ],
            ),
          ),
        ));
  }
}
