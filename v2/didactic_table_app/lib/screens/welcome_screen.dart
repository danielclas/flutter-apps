import 'package:didactic_table_app/components/login_component.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LoginRegisterComponent();
  }
}
