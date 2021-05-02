import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_crud_app/components/rectangle_button.dart';
import 'package:users_crud_app/screens/home_screen.dart';
import 'package:users_crud_app/services/firebase_service.dart';
import 'package:users_crud_app/utils/constants.dart';
import 'package:users_crud_app/utils/hex_color.dart';
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
      width: 80.percentOf(context.width),
      child: Padding(
        padding: EdgeInsets.only(right: 3.percentOf(context.width), left: 3.percentOf(context.width)),
        child: Form(
          key: formKey,
          onChanged: () => formStatusText = '',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.percentOf(context.width), bottom: 2.percentOf(context.width)),
                child: Center(child: Text("Ingrese o regístrese aquí")),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 2.percentOf(context.height), bottom: 1.percentOf(context.height)),
                child: TextFormField(
                    controller: emailController,
                    onChanged: (value) {
                      if (formStatusText != '') setState(() => formStatusText = '');
                    },
                    validator: (value) => EmailValidator.validate(value) ? null : '',
                    keyboardType: TextInputType.emailAddress,
                    //ErrorStyle is given height 0 so that textField doesn't show text error
                    //when invalid, only red outline
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Correo',
                    )),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 2.percentOf(context.height), bottom: 3.percentOf(context.height)),
                child: TextFormField(
                    controller: passwordController,
                    onChanged: (value) => setState(() => formStatusText = ''),
                    validator: (value) => value == null || value.length < 4 ? '' : null,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: 'Contraseña',
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4.percentOf(context.width)),
                child: Center(
                    child: Text(
                  formStatusText,
                  style: TextStyle(color: formStatusTextColor),
                )),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.percentOf(context.height)),
                child: RectangleButton(
                  minWidth: 80.percentOf(context.width),
                  text: 'Ingresar',
                  color: HexColor("903749"),
                  onPressed: login,
                  child: loginChild,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 1.percentOf(context.height)),
                child: RectangleButton(
                  minWidth: 80.percentOf(context.width),
                  text: 'Registrarse',
                  color: HexColor("53354a"),
                  onPressed: register,
                  child: registerChild,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 1.percentOf(context.height)),
                child: RectangleButton(
                  minWidth: 80.percentOf(context.width),
                  text: 'Usuarios',
                  color: HexColor("2b2e4a"),
                  onPressed: switchUser,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
