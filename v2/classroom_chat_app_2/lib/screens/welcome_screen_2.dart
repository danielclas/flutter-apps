import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/login_register_component.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class WelcomeScreen2 extends StatefulWidget {
  static final String id = "WelcomeString2";
  @override
  _WelcomeScreen2State createState() => _WelcomeScreen2State();
}

class _WelcomeScreen2State extends State<WelcomeScreen2> {
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.6),
                  child: Container(
                      decoration: new BoxDecoration(
                        color: HexColor("8fd9a8"),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                MediaQuery.of(context).size.width * 0.7, 150)),
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
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.04),
                    child: Column(
                      children: [
                        TypewriterAnimatedTextKit(
                          text: ['¡Bienvenid@!'],
                          textStyle: TextStyle(
                            fontSize: 30.0,
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ),
                  Material(
                      elevation: 20,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white,
                      child: LoginRegisterComponent()),
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
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
