import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../constants.dart';
import 'package:page_transition/page_transition.dart';
import '../services/login_service.dart';
import 'home_screen.dart';
import 'loading_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  bool isLoading;
  final _loginForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  void tryLogin() async {
    /*isLoading = true;
    bool exists = await LoginService.loginUser(email, password);

    if (exists) {*/
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.downToUp,
        duration: Duration(milliseconds: 300),
        child: Home(),
      ),
    );
    /*} else {
      print("Usuario no existe");
    }*/
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
        body: Center(
          child: isLoading
              ? LoadingScreen()
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/back.png'),
                      repeat: ImageRepeat.repeat,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Form(
                      key: _loginForm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("Deslice para seleccionar un usuario"),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            decoration: BoxDecoration(
                              color: Colors.teal[300],
                              shape: BoxShape.circle,
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                onPressed: () => {
                                      /*if (_loginForm.currentState.validate())
                                        {
                                          _loginForm.currentState.save(),*/
                                      tryLogin(),
                                      /*}
                                      else //f7e044  69fed8
                                        {print("Invalid form")}*/
                                    },
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(
                                    "Ingresar",
                                  ),
                                ),
                                color: Color(0xff8BC34A)),
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
