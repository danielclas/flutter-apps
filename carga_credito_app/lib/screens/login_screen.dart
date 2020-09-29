import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../constants.dart';
import 'package:page_transition/page_transition.dart';
import '../services/login_service.dart';
import 'home_screen.dart';
import 'loading_screen.dart';
import 'package:carga_credito_app/components/login_card.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;
  int userIndex = 0;
  bool isLoading;
  final _loginForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLoading = false;
    emailController.text = kUsers[userIndex]['correo'];
    passwordController.text = kUsers[userIndex]['clave'];
  }

  void tryLogin() async {
    isLoading = true;
    bool exists = await LoginService.loginUser(email, password);

    if (exists) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.downToUp,
          duration: Duration(milliseconds: 300),
          child: Home(),
        ),
      );
    } else {
      print("Usuario no existe");
    }
  }

  List<LoginCard> buildCards() {
    List<LoginCard> list = [];

    for (var user in kUsers) {
      list.add(LoginCard(user['correo'], user['clave']));
    }

    return list;
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
                      image: AssetImage('images/back.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.white70,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white70),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white70),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                              onPressed: () {
                                setState(() {
                                  userIndex =
                                      userIndex == 0 ? 5 : userIndex + 1;

                                  emailController.text =
                                      kUsers[userIndex]['correo'];
                                  passwordController.text =
                                      kUsers[userIndex]['clave'];
                                });
                              },
                              color: Colors.blueGrey,
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.white70,
                              ),
                              shape: CircleBorder()),
                          RaisedButton(
                            color: Colors.blueGrey,
                            onPressed: () {
                              setState(() {
                                tryLogin();
                              });
                            },
                            child: Text(
                              "Ingresar",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white70),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              setState(() {
                                userIndex = userIndex == 5 ? 0 : userIndex + 1;
                                emailController.text =
                                    kUsers[userIndex]['correo'];
                                passwordController.text =
                                    kUsers[userIndex]['clave'];
                              });
                            },
                            color: Colors.blueGrey,
                            child: Icon(Icons.keyboard_arrow_right,
                                color: Colors.white70),
                            shape: CircleBorder(),
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Text(
                            "Seleccione un usuario utilizando los controles",
                            style: TextStyle(color: Colors.white70),
                          )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
