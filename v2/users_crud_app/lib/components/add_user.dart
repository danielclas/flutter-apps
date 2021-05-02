import 'package:barcode_scan/barcode_scan.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:users_crud_app/model/user_model.dart';
import 'package:users_crud_app/services/users_service.dart';
import 'package:users_crud_app/utils/document_parser.dart';
import 'package:users_crud_app/utils/hex_color.dart';
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

  //If form was filled from barcode,
  //fields are marked as readonly
  bool filledFromBarcode = false;

  bool obscurePassword = true;
  bool obscureRepeatPassword = true;

  onAddUserPressed() async {
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
        [
          nameController,
          surnameController,
          passwordController,
          documentController,
          emailController,
          passwordController,
          repeatPasswordController
        ].forEach((c) => c.clear());
      }

      setState(() => buttonChild = null);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void scan() async {
    final barcode = await BarcodeScanner.scan();
    final user = DocumentParser.userFromBarCode(barcode);
    setState(() {
      filledFromBarcode = true;
      nameController.text = user.name;
      surnameController.text = user.surname;
      documentController.text = user.document;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                    controller: nameController,
                    readOnly: filledFromBarcode,
                    validator: (value) => value.length > 3 ? null : '',
                    style: filledFromBarcode ? TextStyle(color: Colors.grey) : null,
                    decoration: InputDecoration(icon: Icon(Icons.label), labelText: 'Nombre(s)')),
                TextFormField(
                    controller: surnameController,
                    readOnly: filledFromBarcode,
                    validator: (value) => value.length > 3 ? null : '',
                    style: filledFromBarcode ? TextStyle(color: Colors.grey) : null,
                    decoration: InputDecoration(icon: Icon(Icons.label), labelText: 'Apellido(s)')),
                TextFormField(
                    controller: documentController,
                    readOnly: filledFromBarcode,
                    validator: (value) => value.length > 5 ? null : '',
                    style: filledFromBarcode ? TextStyle(color: Colors.grey) : null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.contact_mail),
                      suffix: IconButton(onPressed: scan, icon: Icon(Icons.qr_code)),
                      labelText: 'DNI',
                    )),
                TextFormField(
                    controller: emailController,
                    validator: (value) => EmailValidator.validate(value) ? null : '',
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(icon: Icon(Icons.mail), labelText: 'Correo')),
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
                    )),
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
                    )),
                MaterialButton(
                  color: HexColor('e84545'),
                  minWidth: 40.percentOf(context.width),
                  onPressed: onAddUserPressed,
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
