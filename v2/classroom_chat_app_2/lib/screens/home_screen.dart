import 'dart:async';
import 'package:flash_chat/constants.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showSpinner = false, shakeFirst = false, shakeSecond = false;
  int selected = -1;

  onClassroomBoxTap(int index) {
    setState(() {
      selected = selected == index ? -1 : index;
      if (selected == 0)
        shakeFirst = true;
      else if (selected == 1) shakeSecond = true;

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if (selected == 0)
            shakeFirst = false;
          else if (selected == 1) shakeSecond = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(''),
        backgroundColor: HexColor("8fd9a8"),
        shadowColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(),
        inAsyncCall: showSpinner,
        child: Stack(children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: HexColor("4b778d"),
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.6),
                  child: Container(
                      decoration: new BoxDecoration(
                        color: HexColor("8fd9a8"),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(MediaQuery.of(context).size.width * 0.7, 150)),
                      ),
                      height: MediaQuery.of(context).size.height * 0.5),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.04),
                    child: Column(
                      children: [
                        TypewriterAnimatedTextKit(
                          text: ['Bienvenid@, ${FirebaseService.loggedInUser.email.substring(0, 5)}'],
                          textStyle: TextStyle(
                            fontSize: 30.0,
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShakeAnimatedWidget(
                        enabled: shakeFirst,
                        duration: Duration(milliseconds: 150),
                        shakeAngle: Rotation.deg(z: 10),
                        curve: Curves.linear,
                        child: Material(
                            elevation: 20,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () => onClassroomBoxTap(0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(
                                          width: 5, color: selected == 0 ? HexColor("d2e69c") : Colors.transparent)),
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Center(
                                      child: Text(
                                    "4A",
                                    style: TextStyle(fontSize: 30),
                                  ))),
                            )),
                      ),
                      ShakeAnimatedWidget(
                        enabled: shakeSecond,
                        duration: Duration(milliseconds: 150),
                        shakeAngle: Rotation.deg(z: 10),
                        curve: Curves.linear,
                        child: Material(
                            elevation: 20,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () => onClassroomBoxTap(1),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(
                                          width: 5, color: selected == 1 ? HexColor("d2e69c") : Colors.transparent)),
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Center(
                                      child: Text(
                                    "4B",
                                    style: TextStyle(fontSize: 30),
                                  ))),
                            )),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: Text(
                      'Seleccione un aula para continuar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RoundedButton(
                      text: 'Entrar al chat',
                      color: selected == -1 ? Colors.grey : HexColor("28b5b5"),
                      onPressed: () {
                        showSpinner = false;
                        Navigator.pushNamed(context, ChatScreen.id, arguments: "classroom-a");
                      },
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Hero(
                            tag: "graphic",
                            child: SvgPicture.asset(
                              'images/main-graphic.svg',
                              semanticsLabel: 'Main Graphic',
                              width: MediaQuery.of(context).size.width * 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
