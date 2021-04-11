import 'dart:async';
import 'dart:io';

import 'package:administracion_usuarios_app/classes/person.dart';
import 'package:administracion_usuarios_app/services/people_service.dart';

import 'loading_screen.dart';
import '../services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '.././constants.dart';
import 'package:page_transition/page_transition.dart';
import 'home_screen.dart';
import 'package:alert/alert.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class FormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  Color color = Colors.grey;
  bool isLoading = false;

  final _loginForm = GlobalKey<FormState>();

  TextEditingController correoController = TextEditingController();
  TextEditingController claveController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController segundaClaveController = TextEditingController();

  void addPerson() {
    Person p = Person(
        correoController.text,
        claveController.text,
        apellidoController.text,
        nombreController.text,
        int.parse(dniController.text));
    PeopleService.addPerson(p);

    setState(() {
      isLoading = true;
    });

    sleep(Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });

    Alert(message: 'El usuario fue agregado correctamente').show();

    correoController.clear();
    claveController.clear();
    dniController.clear();
    nombreController.clear();
    apellidoController.clear();
    segundaClaveController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
            backgroundColor: color,
            heroTag: 'close',
            onPressed: () {
              setState(() {});
            },
            child: Icon(Icons.camera_alt)),
      ),
      body: Center(
        child: isLoading
            ? LoadingScreen()
            : SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          repeat: ImageRepeat.repeat)),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: _loginForm,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: nombreController,
                                  onChanged: (value) {
                                    setState(() {
                                      _loginForm.currentState.validate();
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    return value.length != 0
                                        ? null
                                        : 'Por favor, ingrese un nombre valido';
                                  },
                                  decoration:
                                      InputDecoration(labelText: 'Nombre(s)'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: apellidoController,
                                  onChanged: (value) {
                                    setState(() {
                                      _loginForm.currentState.validate();
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    return value.length != 0
                                        ? null
                                        : 'Por favor, ingrese un apellido valido';
                                  },
                                  decoration:
                                      InputDecoration(labelText: 'Apellido(s)'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: dniController,
                                  onChanged: (value) {
                                    setState(() {
                                      _loginForm.currentState.validate();
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    return value.length != 0
                                        ? null
                                        : 'Por favor, ingrese un DNI valido';
                                  },
                                  decoration: InputDecoration(labelText: 'DNI'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: correoController,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    setState(() {
                                      _loginForm.currentState.validate();
                                    });
                                  },
                                  onSaved: (value) {},
                                  validator: (value) {
                                    return value.isEmpty
                                        ? 'Por favor, ingrese un correo válido'
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Correo',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: claveController,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _loginForm.currentState.validate();
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    return value.isEmpty
                                        ? 'Por favor, ingrese una contraseña'
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Clave',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: TextFormField(
                                  controller: segundaClaveController,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _loginForm.currentState.validate();
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    return value != claveController.text
                                        ? 'Las contraseñas deben coincidir'
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Reingrese clave',
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () => {
                                  if (_loginForm.currentState.validate())
                                    {
                                      _loginForm.currentState.save(),
                                      addPerson(),
                                    }
                                  else
                                    {print("Invalid form")}
                                },
                                child: Text("Agregar",
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
      ),
    );
  }
}

//TODO: Informar error
