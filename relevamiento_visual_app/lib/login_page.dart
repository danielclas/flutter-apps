import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:relevamiento_visual_app/constants.dart';
import 'package:relevamiento_visual_app/services/login_service.dart';
import 'home_page.dart';
import 'package:bordered_text/bordered_text.dart';

import 'loading_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  int userIndex = 0;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _loginForm = GlobalKey<FormState>();

  void tryLogin() async {
    isLoading = true;
    bool exists = await LoginService.loginUser(email, password);

    if (exists) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      //Informo error
      print("Usuario no existe");
    }
  }

  @override
  void dispose() {
    super.dispose();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Relevamiento visual',
                style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'))),
        body: Center(
          child: isLoading
              ? LoadingScreen()
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/back.png'),
                        repeat: ImageRepeat.repeat),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Form(
                      key: _loginForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('images/login.png'),
                            height: 70.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
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
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.yellow[400],
                                ),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RaisedButton(
                                    onPressed: () => {
                                          if (_loginForm.currentState
                                              .validate())
                                            {
                                              _loginForm.currentState.save(),
                                              tryLogin(),
                                            }
                                          else
                                            {print("Invalid form")}
                                        },
                                    child: BorderedText(
                                      strokeWidth: 4.0,
                                      strokeColor: Colors.black54,
                                      child: Text(
                                        "Ingresar",
                                        style: kTitlesTextStyle.copyWith(
                                            fontSize: 15, letterSpacing: 2.0),
                                      ),
                                    ),
                                    color: ThemeData.dark().accentColor),
                                RaisedButton(
                                    onPressed: () => {
                                          setState(() {
                                            _loginForm.currentState.reset();

                                            emailController.text =
                                                kUsers[userIndex]['correo'];
                                            passwordController.text =
                                                kUsers[userIndex]['clave'];

                                            userIndex = userIndex == 5
                                                ? 0
                                                : userIndex + 1;
                                          })
                                        },
                                    child: BorderedText(
                                      strokeWidth: 4.0,
                                      strokeColor: Colors.black54,
                                      child: Text(
                                        "Usuarios",
                                        style: kTitlesTextStyle.copyWith(
                                            fontSize: 15, letterSpacing: 2.0),
                                      ),
                                    ),
                                    color: ThemeData.dark().accentColor),
                              ],
                            ),
                          )
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

//TODO: Informar error
