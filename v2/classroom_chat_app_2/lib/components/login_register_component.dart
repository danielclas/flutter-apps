import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int userIndex = 0;
  String formStatusText = '';
  Color formStatusTextColor = Colors.redAccent;
  Widget loginChild;
  Widget registerChild;

  switchUser() {
    setState(() {
      formKey.currentState.reset();
      userIndex = userIndex == 5 ? 0 : userIndex + 1;
      emailController.text = kUsers[userIndex]['email'];
      passwordController.text = kUsers[userIndex]['password'];
      formStatusText = '';
      formStatusTextColor = Colors.redAccent;
      loginChild = null;
      registerChild = null;
    });
  }

  register() async {
    if (!formKey.currentState.validate()) {
      return setState(() => formStatusText = 'El correo o la contraseña no son válidos');
    }
    setState(() => registerChild = CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2,
        ));
    try {
      UserCredential user = await FirebaseService.register(emailController.text, passwordController.text);
      if (user != null) {
        setState(() => registerChild = Icon(Icons.check, color: Colors.white));
        formStatusTextColor = Colors.green;
        formStatusText = 'Usuario registrado exitosamente';
        Timer(Duration(seconds: 2), () {
          setState(() => registerChild = null);
        });
      }
    } catch (e) {
      formStatusText = 'No fue posible registrarse';
      setState(() => registerChild = null);
    }
  }

  login() async {
    if (!formKey.currentState.validate()) {
      return setState(() => formStatusText = 'El correo o la contraseña no son válidos');
    }

    setState(() => loginChild = CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2,
        ));

    try {
      UserCredential user = await FirebaseService.signIn(emailController.text, passwordController.text);
      if (user != null) {
        setState(() => loginChild = Icon(Icons.check, color: Colors.white));
        formKey.currentState.reset();
        Navigator.pushNamed(context, HomeScreen.id);
        Timer(Duration(seconds: 2), () {
          setState(() => loginChild = null);
        });
      }
    } catch (e) {
      formStatusText = 'No fue posible autenticarse';
      setState(() => loginChild = null);
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.text = kUsers[userIndex]['email'];
    passwordController.text = kUsers[userIndex]['password'];
    loginChild = null;
    registerChild = null;
  }

  @override
  void dispose() {
    super.dispose();
    loginChild = null;
    registerChild = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 1),
        child: Form(
          key: formKey,
          onChanged: () => formStatusText = '',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 8),
                child: Center(child: Text("Ingrese o regístrese aquí")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 15),
                child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: emailController,
                    onChanged: (value) => setState(() => formStatusText = ''),
                    validator: (value) => EmailValidator.validate(value) ? null : "",
                    keyboardType: TextInputType.emailAddress,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Correo', labelStyle: TextStyle(color: Colors.black54), errorStyle: TextStyle(height: 0))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 25),
                child: SizedBox(
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: passwordController,
                      onChanged: (value) => setState(() => formStatusText = ''),
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
                child: Center(
                    child: Text(
                  formStatusText,
                  style: TextStyle(color: formStatusTextColor),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                  minWidth: 300,
                  text: 'Ingresar',
                  color: HexColor("8fd9a8"),
                  onPressed: login,
                  child: loginChild,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedButton(
                      minWidth: MediaQuery.of(context).size.height * 0.17,
                      text: 'Registrarse',
                      color: HexColor("28b5b5"),
                      onPressed: register,
                      child: registerChild,
                    ),
                    RoundedButton(
                      minWidth: MediaQuery.of(context).size.height * 0.17,
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
