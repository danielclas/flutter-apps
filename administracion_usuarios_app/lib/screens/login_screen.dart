import 'loading_screen.dart';
import '../services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '.././constants.dart';
import 'package:page_transition/page_transition.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color color = Colors.orange[200];
  int userIndex = 0;
  String email;
  String password;
  bool isLoading = false;

  final _loginForm = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void tryLogin() async {
    isLoading = true;
    bool exists = await LoginService.loginUser(
        emailController.text, passwordController.text);

    if (exists) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.scale,
          child: Home(),
        ),
      );
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
        resizeToAvoidBottomInset: false,
        floatingActionButton: Visibility(
          visible: !isLoading,
          child: FloatingActionButton(
              backgroundColor: color,
              heroTag: 'close',
              onPressed: () {
                setState(() {
                  _loginForm.currentState.reset();

                  emailController.text = kUsers[userIndex]['correo'];
                  passwordController.text = kUsers[userIndex]['clave'];

                  userIndex = userIndex == 5 ? 0 : userIndex + 1;
                });
              },
              child: Icon(Icons.person)),
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange[200],
          title: Text(
            'Administración de usuarios',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: isLoading
              ? LoadingScreen()
              : Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          repeat: ImageRepeat.repeat)),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _loginForm,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                child: Text(
                                  'Bienvenido',
                                  style: TextStyle(fontSize: 20),
                                ),
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
                                  decoration:
                                      InputDecoration(labelText: 'E-mail'),
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
                                  else
                                    {print("Invalid form")}
                                },
                                child: Text("Ingresar",
                                    style: TextStyle(fontSize: 20)),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                                child: Text(
                                  'Ingrese para cargar o ver el listado',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
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
