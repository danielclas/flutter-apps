import 'package:email_validator/email_validator.dart';
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
  final formKey = GlobalKey<FormState>();
  int userIndex = 0;
  String userEmail;
  String userPassword;
  String formStatusText = '';

  switchUser() {
    setState(() {
      formKey.currentState.reset();
      userIndex = userIndex == 5 ? 0 : userIndex + 1;
      emailController.text = kUsers[userIndex]['email'];
      passwordController.text = kUsers[userIndex]['password'];
      formStatusText = '';
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.text = kUsers[userIndex]['email'];
    passwordController.text = kUsers[userIndex]['password'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 25),
        child: Form(
          key: formKey,
          onChanged: () => formStatusText = '',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Ingrese o regístrese aquí")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
                child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: emailController,
                    validator: (value) => EmailValidator.validate(value) ? null : "",
                    keyboardType: TextInputType.emailAddress,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Correo',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 25),
                child: SizedBox(
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: passwordController,
                      validator: (value) => value == null || value.length < 4 ? "P" : null,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.black54),
                          errorStyle: TextStyle(height: 0, color: Colors.transparent))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Center(child: Text(formStatusText)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                  minWidth: 300,
                  text: 'Ingresar',
                  color: HexColor("8fd9a8"),
                  onPressed: () async {
                    if (!formKey.currentState.validate()) {
                      return setState(() => formStatusText = 'El correo o la contraseña no son válidos');
                    }

                    setState(() => showSpinner = true);
                    try {
                      UserCredential user = await FirebaseService.auth.signInWithEmailAndPassword(
                          email: emailController.value.text, password: passwordController.value.text);
                      if (user != null) {
                        formKey.currentState.reset();
                        Navigator.pushNamed(context, HomeScreen.id);
                      } else {
                        formStatusText = 'No fue posible autenticarse';
                      }

                      setState(() => showSpinner = false);
                    } catch (e) {
                      setState(() => showSpinner = false);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedButton(
                      minWidth: 130,
                      text: 'Registrarse',
                      color: HexColor("28b5b5"),
                      onPressed: () async {
                        setState(() => showSpinner = true);
                        try {
                          UserCredential user =
                              await FirebaseService.auth.signInWithEmailAndPassword(email: "", password: "");
                          if (user != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          } else {
                            formStatusText = 'No fue posible registrarse';
                          }
                          setState(() => showSpinner = false);
                        } catch (e) {
                          setState(() => showSpinner = false);
                        }
                      },
                    ),
                    RoundedButton(
                      minWidth: 130,
                      text: 'Usuarios',
                      color: HexColor("28b5b5"),
                      onPressed: () => switchUser(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
