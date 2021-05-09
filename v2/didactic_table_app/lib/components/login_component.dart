import 'dart:async';
import 'package:didactic_table_app/components/custom_slider.dart';
import 'package:didactic_table_app/components/rounded_button.dart';
import 'package:didactic_table_app/screens/home_screen.dart';
import 'package:didactic_table_app/utils/constants.dart';
import 'package:didactic_table_app/utils/hex_color.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../services/firebase_service.dart';
import '../utils/extension_methods.dart';

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
  Widget loginChild, registerChild;
  final Widget spinner = CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    strokeWidth: 2,
  );
  final Widget checkIcon = Icon(Icons.check, color: Colors.white);

  switchUser() {
    //When the 'users' button is pressed, we select a different
    //user from preset users, and refresh the view
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
    setState(() => registerChild = spinner);
    try {
      UserCredential user = await FirebaseService.register(emailController.text, passwordController.text);
      if (user != null) {
        setState(() => registerChild = checkIcon);
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

    setState(() => loginChild = spinner);

    try {
      UserCredential user = await FirebaseService.signIn(emailController.text, passwordController.text);
      if (user != null) {
        setState(() => loginChild = checkIcon);
        formKey.currentState.reset();
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              duration: Duration(milliseconds: 500),
              child: HomeScreen(),
            )).then((_) {
          //This is done so that when we pop from the next screen,
          //form is clean
          emailController.clear();
          passwordController.clear();
          userIndex = 0;
        });
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10.percentOf(context.height)),
          child: Text(
            '¡Bienvenid@!',
            style: TextStyle(
              fontSize: 12.percentOf(context.width),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.percentOf(context.width)),
          height: 60.percentOf(context.height),
          width: 100.percentOf(context.width),
          child: Form(
            key: formKey,
            onChanged: () => formStatusText = '',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(2.percentOf(context.height)),
                  child: Center(child: Text("Ingrese o regístrese aquí")),
                ),
                TextFormField(
                    textAlign: TextAlign.center,
                    controller: emailController,
                    onChanged: (value) {
                      if (formStatusText != '') setState(() => formStatusText = '');
                    },
                    validator: (value) => EmailValidator.validate(value) ? null : '',
                    keyboardType: TextInputType.emailAddress,
                    //ErrorStyle is given height 0 so that textField doesn't show text error
                    //when invalid, only red outline
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Correo',
                        hintStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
                SizedBox(
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: passwordController,
                      onChanged: (value) => setState(() => formStatusText = ''),
                      validator: (value) => value == null || value.length < 4 ? '' : null,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Contraseña',
                          hintStyle: TextStyle(color: Colors.black54),
                          errorStyle: TextStyle(height: 0))),
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 2.percentOf(context.height)),
                    child: Text(
                      formStatusText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: formStatusTextColor),
                    )),
                RoundedButton(
                  minWidth: 80.percentOf(context.width),
                  text: 'Ingresar',
                  color: HexColor("f38181"),
                  onPressed: login,
                  child: loginChild,
                ),
                RoundedButton(
                  minWidth: 80.percentOf(context.height),
                  text: 'Registrarse',
                  color: HexColor("95e1d3"),
                  onPressed: register,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.percentOf(context.height)),
                  decoration: BoxDecoration(
                    color: Colors.teal[300],
                    shape: BoxShape.circle,
                  ),
                  child: CustomSlider(children: kUserIcons, handler: (index, b) => switchUser()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
