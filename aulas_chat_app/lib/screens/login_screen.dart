import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:aulas_chat_app/constants.dart';
import 'package:page_transition/page_transition.dart';
import '../services/login_service.dart';
import 'home_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  final _loginForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void tryLogin() async {
    bool exists = await LoginService.loginUser(email, password);

    if (exists) {
      _loginForm.currentState.reset();
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.downToUp,
          child: Home(),
        ),
      );
    } else {
      //Informo error
      print("Usuario no existe");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/back.png'),
                repeat: ImageRepeat.repeat,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Form(
                key: _loginForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      decoration: BoxDecoration(
                        color: Colors.teal[300],
                        shape: BoxShape.circle,
                      ),
                      child: CarouselSlider(
                        items: kUserIcons,
                        options: CarouselOptions(
                          height: 100,
                          viewportFraction: 0.4,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          enlargeCenterPage: true,
                          onPageChanged: (index, b) {
                            setState(() {
                              emailController.text = kUsers[index]['correo'];
                              passwordController.text = kUsers[index]['clave'];
                            });
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        controller: emailController,
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
                          labelText: 'E-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        controller: passwordController,
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
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: RaisedButton(
                          onPressed: () => {
                                if (_loginForm.currentState.validate())
                                  {
                                    _loginForm.currentState.save(),
                                    tryLogin(),
                                  }
                                else //f7e044  69fed8
                                  {print("Invalid form")}
                              },
                          child: Text(
                            "Login",
                            style: kTitlesTextStyle.copyWith(
                                fontSize: 20, letterSpacing: 2.0),
                          ),
                          color: ThemeData.dark().accentColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}