import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/login_register_component.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../utils/extension_methods.dart';

class WelcomeScreen extends StatefulWidget {
  static final String id = "WelcomeString2";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //Body of scaffold is placed on a stack
      //so that containers can be used to draw the background
      body: Stack(children: [
        //The next 2 columns draw the bi-color background
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
          padding: EdgeInsets.only(
              top: 5.percentOf(context.height),
              bottom: 3.percentOf(context.height),
              left: 2.percentOf(context.height),
              right: 2.percentOf(context.height)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.percentOf(context.height)),
                  child: Column(
                    children: [
                      TypewriterAnimatedTextKit(
                        text: ['¡Bienvenid@!'],
                        textStyle: TextStyle(
                          fontSize: 12.percentOf(context.width),
                        ),
                        speed: Duration(milliseconds: 100),
                      ),
                    ],
                  ),
                ),
                //Main login and register component that is placed
                //on a Material widget to add elevation, etc.
                Material(
                    elevation: 20,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                    child: LoginRegisterComponent()),
                Padding(
                  padding:
                      EdgeInsets.only(top: 4.percentOf(context.height), bottom: 1.percentOf(context.height)),
                  child: Hero(
                    //Using Hero widget to animate transition to 2nd screen
                    tag: "graphic",
                    child: Image(
                      height: 20.percentOf(context.height),
                      width: 40.percentOf(context.width),
                      image: Svg(
                        'images/main-graphic.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
