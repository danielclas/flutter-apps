import 'loading_screen.dart';
import './services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'home_page.dart';
import 'constants.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int boxColorsIndex = 0;
  Color color = kBoxColors[0];
  int userIndex = 0;
  String email;
  String password;
  bool isLoading = false;
  final _loginForm = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void tryLogin() async {
    isLoading = true;
    bool exists = await LoginService.loginUser(email, password);

    if (exists) {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
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
    return Scaffold(
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

                boxColorsIndex = boxColorsIndex == 4 ? 0 : boxColorsIndex + 1;
                color = kBoxColors[boxColorsIndex];

                userIndex = userIndex == 5 ? 0 : userIndex + 1;
              });
            },
            child: Icon(Icons.person)),
      ),
      appBar: AppBar(
          title:
              Text('Tabla Didactica', style: TextStyle(color: Colors.white))),
      body: Center(
        child: isLoading
            ? LoadingScreen()
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/back.png'),
                        fit: BoxFit.cover)),
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
