import 'dart:math';
import './services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'home_page.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int userIndex = 0;
  String email;
  String password;
  final _loginForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
          heroTag: 'close',
          onPressed: () {
            setState(() {
              emailController.text = kUsers[userIndex]['correo'];
              passwordController.text = kUsers[userIndex]['clave'];
              userIndex = userIndex == 5 ? 0 : userIndex + 1;
            });
          },
          child: Icon(Icons.person)),
      appBar: AppBar(
          title:
              Text('Tabla Didactica', style: TextStyle(color: Colors.white))),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/back.png'), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/login.png',
                        width: 150,
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('images/por.png'),
                    Image.asset('images/esp.png'),
                    Image.asset('images/eng.png'),
                  ],
                ),
                Form(
                  key: _loginForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          decoration: InputDecoration(labelText: 'E-mail'),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()))
                          /*if (_loginForm.currentState.validate())
                            {
                              _loginForm.currentState.save(),
                              tryLogin(),
                            }
                          else //f7e044  69fed8
                            {print("Invalid form")}*/
                        },
                        child: Text(
                          "Ingresar",
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
    );
  }
}

//TODO: Informar error
