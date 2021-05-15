import 'package:flutter/material.dart';
import 'package:visual_survey_app/components/login_component.dart';
import 'package:visual_survey_app/utils/hex_color.dart';
import '../utils/extension_methods.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: HexColor('323232'),
          title: Text('Relevamiento visual'),
          centerTitle: true,
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.png'), scale: 0.1, repeat: ImageRepeat.repeat),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: 5.percentOf(context.height), horizontal: 10.percentOf(context.width)),
              child: LoginRegisterComponent())
        ]));
  }
}
