import 'dart:async';
import 'package:alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theft_alarm_app/services/firebase_service.dart';
import 'package:theft_alarm_app/utils/hex_color.dart';
import 'package:torch/torch.dart';
import 'package:vibration/vibration.dart';
import '../services/tts_service.dart';
import 'dart:ui';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HomeScreen";

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Color color = HexColor('e45826');
  String label = 'Activar la alarma';
  IconData icon = Icons.alarm_add;

  bool isPortraitMode = false;

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Tts.initializeTts();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    if (this.color == Colors.grey) {
      setState(() {
        isPortraitMode = window.physicalSize.width > window.physicalSize.height;
        if (isPortraitMode) {
          Torch.turnOn();
          Timer(Duration(seconds: 5), () => Torch.turnOff());
          Tts.speak(kWarnings[0]);
        } else {
          Tts.speak(kWarnings[1]);
          Vibration.vibrate(duration: 5000);
        }
      });
    }
  }

  void onTap() {
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: HexColor('e6d5b8'),
            title: Text(
              "Ingrese contraseña",
              style: TextStyle(color: Colors.black),
            ),
            content: TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor('e45826'), width: 0.0),
                ),
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Ingresar",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    if ("123456" == passwordController.text) {
                      this.color = this.color == HexColor('f0a500') ? HexColor('e45826') : HexColor('f0a500');
                      this.label =
                          this.color == HexColor('f0a500') ? 'Desactivar la alarma' : 'Activar la alarma';
                      this.icon = this.color == HexColor('f0a500') ? Icons.alarm_off : Icons.alarm_add;
                      Navigator.of(context).pop();
                    } else {
                      Alert(message: 'La contraseña ingresada no es correcta').show();
                    }
                  });
                },
              ),
              FlatButton(
                child: Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Alarma de robo"),
          backgroundColor: HexColor('4a3933'),
        ),
        body: Container(
          color: HexColor('f0a500'),
          child: Center(
            child: Flex(
              direction: isPortraitMode ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flex(
                  direction: isPortraitMode ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Bienvenido, ${FirebaseService.loggedInUser.email.substring(0, FirebaseService.loggedInUser.email.indexOf('@'))}",
                      style: TextStyle(fontSize: isPortraitMode ? 15 : 30, color: Colors.white),
                    )
                  ],
                ),
                Flex(
                  direction: isPortraitMode ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white70, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(70),
                            ),
                          ),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Flex(
                                direction: isPortraitMode ? Axis.horizontal : Axis.vertical,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    icon,
                                    color: color,
                                    size: isPortraitMode ? 50 : 200,
                                  ),
                                  Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Flex(
                  direction: isPortraitMode ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Presione en el icono \n para ${label[0].toLowerCase()}${label.substring(1)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isPortraitMode ? 15 : 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
