import 'dart:io';
import 'package:alarma_robo_app/services/login_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../constants.dart';
import 'package:alert/alert.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  Color color = Colors.grey;
  String label = 'Desactivar la alarma';
  IconData icon = Icons.alarm_off;
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      print(window.physicalSize.width);
      print(window.physicalSize.height);
    });
  }

  void onTap() {
    setState(() {
      this.color = this.color == Colors.grey ? Colors.red[500] : Colors.grey;
      this.label = this.color == Colors.grey
          ? 'Desactivar la alarma'
          : 'Activar la alarma';
      this.icon = this.color == Colors.grey ? Icons.alarm_off : Icons.alarm_add;

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
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[500], width: 0.0),
                ),
                labelStyle: TextStyle(color: Colors.white70),
                labelText: 'Password',
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
                  print("contraseña");
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
        resizeToAvoidBottomPadding: false,
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
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Bienvenido, ${LoginService.user.correo.substring(0, LoginService.user.correo.indexOf('@'))}",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )
                        ],
                      ),
                      Row(
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
                                  border: Border.all(
                                      color: Colors.white70, width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(70),
                                  ),
                                ),
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          icon,
                                          color: color,
                                          size: 200,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Presione en el icono \n para ${label[0].toLowerCase()}${label.substring(1)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
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
