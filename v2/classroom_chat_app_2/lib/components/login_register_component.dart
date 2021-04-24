import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginRegisterComponent extends StatefulWidget {
  @override
  _LoginRegisterComponentState createState() => _LoginRegisterComponentState();
}

class _LoginRegisterComponentState extends State<LoginRegisterComponent> {
  bool showSpinner = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04),
              child: Text("Correo electrónico"),
            ),
            TextField(
                controller: emailController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Ingresa tu correo')),
            Container(
                child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.04),
              child: Text("Contraseña"),
            )),
            TextField(
                controller: passwordController,
                textAlign: TextAlign.center,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Ingresa tu contraseña')),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.06),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedButton(
                      text: 'Ingresar',
                      color: HexColor("8fd9a8"),
                      onPressed: () async {
                        setState(() => showSpinner = true);
                        try {
                          UserCredential user = await FirebaseService.auth
                              .signInWithEmailAndPassword(
                                  email: emailController.value.text,
                                  password: passwordController.value.text);
                          if (user != null) {
                            emailController.clear();
                            passwordController.clear();
                            Navigator.pushNamed(context, HomeScreen.id);
                          }
                          setState(() => showSpinner = false);
                        } catch (e) {
                          setState(() => showSpinner = false);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedButton(
                      text: 'Registrarse',
                      color: HexColor("28b5b5"),
                      onPressed: () async {
                        setState(() => showSpinner = true);
                        try {
                          UserCredential user = await FirebaseService.auth
                              .signInWithEmailAndPassword(
                                  email: "", password: "");
                          if (user != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          setState(() => showSpinner = false);
                        } catch (e) {
                          setState(() => showSpinner = false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
