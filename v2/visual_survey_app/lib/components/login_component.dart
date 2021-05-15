import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:visual_survey_app/components/rectangle_button.dart';
import 'package:visual_survey_app/screens/home_screen.dart';
import 'package:visual_survey_app/services/firebase_service.dart';
import 'package:visual_survey_app/utils/constants.dart';
import 'package:visual_survey_app/utils/hex_color.dart';
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

  final InputDecoration kTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black.withOpacity(0.3), width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: HexColor('14ffec'), width: 2.0),
    ),
  );

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
      final user = await FirebaseService.register(emailController.text, passwordController.text);
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
      final user = await FirebaseService.signIn(emailController.text, passwordController.text);
      if (user != null) {
        setState(() => loginChild = checkIcon);
        formKey.currentState.reset();
        Navigator.pushNamed(context, HomeScreen.id).then((_) {
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
    return Container(
      height: 70.percentOf(context.height),
      width: 80.percentOf(context.width),
      child: Padding(
        padding: EdgeInsets.only(right: 3.percentOf(context.width), left: 3.percentOf(context.width)),
        child: Form(
          key: formKey,
          onChanged: () => formStatusText = '',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: Image(
                      height: 15.percentOf(context.height), image: Svg('images/welcome-screen-graphic.svg'))),
              Padding(
                padding: EdgeInsets.only(top: 4.percentOf(context.width), bottom: 2.percentOf(context.width)),
                child: Center(child: Text("Ingrese o regístrese aquí")),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 2.percentOf(context.width),
                    right: 2.percentOf(context.width),
                    top: 2.percentOf(context.height),
                    bottom: 1.percentOf(context.height)),
                child: TextFormField(
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
                        labelText: 'Correo',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 2.percentOf(context.width),
                    right: 2.percentOf(context.width),
                    top: 2.percentOf(context.height),
                    bottom: 3.percentOf(context.height)),
                child: SizedBox(
                  child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: passwordController,
                      onChanged: (value) => setState(() => formStatusText = ''),
                      validator: (value) => value == null || value.length < 4 ? '' : null,
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(color: Colors.black54),
                          errorStyle: TextStyle(height: 0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4.percentOf(context.width)),
                child: Center(
                    child: Text(
                  formStatusText,
                  style: TextStyle(color: formStatusTextColor),
                )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 1.percentOf(context.width),
                    bottom: 1.percentOf(context.width),
                    left: 2.percentOf(context.width),
                    right: 2.percentOf(context.width)),
                child: RectangleButton(
                  minWidth: 80.percentOf(context.width),
                  text: 'Ingresar',
                  color: HexColor("14ffec"),
                  onPressed: login,
                  child: loginChild,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 2.percentOf(context.width),
                    right: 2.percentOf(context.width),
                    top: 1.percentOf(context.width)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RectangleButton(
                      minWidth: 18.percentOf(context.height),
                      text: 'Registrarse',
                      color: HexColor("0d7377"),
                      onPressed: register,
                      child: registerChild,
                    ),
                    RectangleButton(
                      minWidth: 18.percentOf(context.height),
                      text: 'Usuarios',
                      color: HexColor("323232"),
                      onPressed: switchUser,
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
