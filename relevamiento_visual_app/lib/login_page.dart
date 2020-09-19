import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:relevamiento_visual_app/constants.dart';
import 'package:relevamiento_visual_app/services/login_service.dart';
import 'home_page.dart';
import 'package:bordered_text/bordered_text.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  final _loginForm = GlobalKey<FormState>();

  void tryLogin() async {
    bool exists = await LoginService.loginUser(email, password);

    if (exists) {
      _loginForm.currentState.reset();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      //Informo error
      print("Usuario no existe");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Relevamiento visual',
              style: TextStyle(color: Colors.white))),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/back.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _loginForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/login.png'),
                    height: 100.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          _loginForm.currentState.validate();
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        return EmailValidator.validate(value)
                            ? null
                            : 'Por favor, ingrese un email valido';
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.yellow[400],
                          ),
                          labelText: 'E-mail'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _loginForm.currentState.validate();
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        return value.isEmpty
                            ? 'Por favor, ingrese una contraseña'
                            : null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.yellow[400],
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  RaisedButton(
                      onPressed: () => {
                            if (_loginForm.currentState.validate())
                              {
                                _loginForm.currentState.save(),
                                tryLogin(),
                              }
                            else //f7e044  69fed8
                              {print("Invalid form")}
                          },
                      child: BorderedText(
                        strokeWidth: 4.0,
                        strokeColor: Colors.black54,
                        child: Text("Login",
                            style: kTitlesTextStyle.copyWith(
                                fontSize: 20, letterSpacing: 2.0)),
                      ),
                      color: ThemeData.dark().accentColor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: Informar error
