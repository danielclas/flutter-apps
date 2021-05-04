import 'package:flutter/material.dart';
import 'package:visual_survey_app/components/login_component.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoginRegisterComponent(),
      ),
    );
  }
}
