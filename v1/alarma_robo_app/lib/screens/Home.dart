import 'dart:async';
import 'package:alarma_robo_app/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import '../services/tts_service.dart';
import 'dart:ui';
import 'package:vibration/vibration.dart';
import 'package:torch_compat/torch_compat.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  Color color = Colors.red[500];
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
          TorchCompat.turnOn();
          Timer(Duration(seconds: 5), () => TorchCompat.turnOff());
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
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(70),
              ),
            ),
            title: Text(
              "Ingrese contraseña",
              style: TextStyle(color: Colors.white),
            ),
            content: TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Colors.green,
                focusColor: Colors.green,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[500], width: 0.0),
                ),
                labelStyle: TextStyle(color: Colors.white70),
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
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    this.color = this.color == Colors.grey ? Colors.red[500] : Colors.grey;
                    this.label = this.color == Colors.grey ? 'Desactivar la alarma' : 'Activar la alarma';
                    this.icon = this.color == Colors.grey ? Icons.alarm_off : Icons.alarm_add;
                    Navigator.of(context).pop();
                  });
                },
              ),
              FlatButton(
                child: Text(
                  "Cerrar",
                  style: TextStyle(color: Colors.white),
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
          backgroundColor: Colors.black38,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/back.png'),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                margin: isPortraitMode ? EdgeInsets.fromLTRB(35, 0, 0, 0) : EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Center(
                  child: Flex(
                    direction: isPortraitMode ? Axis.horizontal : Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flex(
                        direction: isPortraitMode ? Axis.horizontal : Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Bienvenido, ${LoginService.user.correo.substring(0, LoginService.user.correo.indexOf('@'))}",
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
              )),
        ),
      ),
    );
  }
}
