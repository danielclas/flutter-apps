import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:users_crud_app/model/user_model.dart';
import 'package:users_crud_app/services/users_service.dart';
import '../utils/extension_methods.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final documentController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final Widget buttonText = Text('Registrar Usuario');
  Widget buttonChild;

  bool obscurePassword = true;
  bool obscureRepeatPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                    controller: nameController,
                    validator: (value) => value.length > 6 ? null : '',
                    decoration: InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'Nombre(s)',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
                TextFormField(
                    controller: surnameController,
                    validator: (value) => value.length > 6 ? null : '',
                    decoration: InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'Apellido(s)',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
                TextFormField(
                    controller: documentController,
                    validator: (value) => value.length > 7 ? null : '',
                    decoration: InputDecoration(
                        icon: Icon(Icons.contact_mail),
                        labelText: 'DNI',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
                TextFormField(
                    controller: emailController,
                    validator: (value) => EmailValidator.validate(value) ? null : '',
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(Icons.mail),
                        labelText: 'Correo',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
                TextFormField(
                    controller: passwordController,
                    maxLength: 25,
                    validator: (value) => value.length > 6 ? null : '',
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        suffix: IconButton(
                            onPressed: () => setState(() => obscurePassword = !obscurePassword),
                            icon: Icon(Icons.remove_red_eye)),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
                TextFormField(
                    controller: repeatPasswordController,
                    maxLength: 25,
                    validator: (value) => value.length < 6 || value != passwordController.text ? '' : null,
                    obscureText: obscureRepeatPassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key),
                        suffix: IconButton(
                            onPressed: () => setState(() => obscureRepeatPassword = !obscureRepeatPassword),
                            icon: Icon(Icons.remove_red_eye)),
                        labelText: 'Repetir Contraseña',
                        labelStyle: TextStyle(color: Colors.black54),
                        errorStyle: TextStyle(height: 0))),
                MaterialButton(
                  color: Colors.blue,
                  minWidth: 40.percentOf(context.width),
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (formKey.currentState.validate()) {
                      setState(() {
                        buttonChild = Container(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 1,
                            ),
                          ),
                        );
                      });
                      User user = User(
                          name: nameController.text,
                          surname: surnameController.text,
                          email: emailController.text,
                          document: documentController.text);
                      final success = await UsersService.addUser(user, passwordController.text);
                      String message = 'No fue posible agregar al usuario';
                      if (success) {
                        message = 'El usuario fue agregado correctamente';
                        formKey.currentState.reset();
                      }

                      setState(() => buttonChild = null);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                    }
                  },
                  child: buttonChild == null ? buttonText : buttonChild,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
