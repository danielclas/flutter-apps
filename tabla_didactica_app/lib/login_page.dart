import 'dart:math';
import './services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'home_page.dart';
import 'package:unicorndial/unicorndial.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //TEST

  Widget profileOption({IconData iconData, Function onPressed}) {
    return UnicornButton(
        currentButton: FloatingActionButton(
      backgroundColor: Colors.grey[500],
      mini: true,
      child: Icon(iconData),
      onPressed: onPressed,
    ));
  }

  List<UnicornButton> getProfileMenu() {
    List<UnicornButton> children = [];

    children
        .add(profileOption(iconData: Icons.account_balance, onPressed: () {}));
    children.add(profileOption(iconData: Icons.settings, onPressed: () {}));
    children.add(profileOption(
        iconData: Icons.subdirectory_arrow_left, onPressed: () {}));

    return children;
  }

  //TEST
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

  /*UnicornDialer(
  parentButtonBackground: Colors.grey[700],
  orientation: UnicornOrientation.HORIZONTAL,
  parentButton: Icon(Icons.person),
  childButtons: getProfileMenu(),
  ),*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: 'save',
              onPressed: () {
                // What you want to do
              },
              child: Icon(Icons.save),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: 'close',
              onPressed: () {},
              child: Icon(Icons.close),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
          ),
        ],
      ),
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
                      decoration: InputDecoration(labelText: 'E-mail'),
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
                      "Login",
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
