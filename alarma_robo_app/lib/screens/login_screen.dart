import 'dart:io';

import 'package:alarma_robo_app/classes/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:alarma_robo_app/constants.dart';
import 'package:page_transition/page_transition.dart';
import '../services/login_service.dart';
import 'Home.dart';
import 'loading_screen.dart';
import '../components/user_box.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  bool isLoading;
  List<Color> boxes = [];

  @override
  void initState() {
    super.initState();
    isLoading = false;

    for (int i = 0; i < 5; i++) boxes.add(Colors.transparent);
  }

  void tryLogin() async {
    setState(() {
      isLoading = true;
    });
    bool exists = await LoginService.loginUser(email, password);

    if (exists) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 300),
          child: Home(),
        ),
      );
    } else {
      print("Usuario no existe");
    }
  }

  void flickColors(int index) {
    for (int i = 0; i < boxes.length; i++) {
      boxes[i] = i == index ? Colors.grey.withOpacity(0.5) : Colors.transparent;
    }
  }

  @override
  void dispose() {
    super.dispose();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: isLoading
              ? LoadingScreen()
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "¡Bienvenido! \n Seleccione un usuario",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              email = kUsers[0]['correo'];
                              password = kUsers[0]['clave'];
                              setState(() {
                                flickColors(0);
                              });
                            },
                            child: UserBox(
                              user: kUsers[0]['correo'],
                              color: boxes[0],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              email = kUsers[1]['correo'];
                              password = kUsers[1]['clave'];
                              setState(() {
                                flickColors(1);
                              });
                            },
                            child: UserBox(
                              user: kUsers[1]['correo'],
                              color: boxes[1],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              email = kUsers[2]['correo'];
                              password = kUsers[2]['clave'];
                              setState(() {
                                flickColors(2);
                              });
                            },
                            child: UserBox(
                              user: kUsers[2]['correo'],
                              color: boxes[2],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              email = kUsers[3]['correo'];
                              password = kUsers[3]['clave'];
                              setState(() {
                                flickColors(3);
                              });
                            },
                            child: UserBox(
                              user: kUsers[3]['correo'],
                              color: boxes[3],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              email = kUsers[4]['correo'];
                              password = kUsers[4]['clave'];
                              setState(() {
                                flickColors(4);
                              });
                            },
                            child: UserBox(
                              user: kUsers[4]['correo'],
                              color: boxes[4],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              tryLogin();
                            },
                            child: UserBox(
                              user: kUsers[5]['correo'],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
