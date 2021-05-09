import 'package:didactic_table_app/components/login_component.dart';
import 'package:didactic_table_app/utils/hex_color.dart';
import 'package:flutter/material.dart';

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
          centerTitle: true,
          title: Text(
            'Tabla didáctica',
          ),
          backgroundColor: HexColor('f38181'),
        ),
        body: Container(color: HexColor('fce38a'), child: LoginRegisterComponent()));
  }
}
