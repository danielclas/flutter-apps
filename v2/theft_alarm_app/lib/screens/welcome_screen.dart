import 'package:flutter/material.dart';
import 'package:theft_alarm_app/components/login_register_component.dart';
import 'package:theft_alarm_app/utils/hex_color.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: Text("Alarma de robo"),
        backgroundColor: HexColor('4a3933'),
      ),
      body: Container(
        color: HexColor('f0a500'),
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
      ),
    );
  }
}
