import 'package:flutter/material.dart';

import 'hex_color.dart';

const kUsers = [
  {"email": "", "password": ""},
  {"email": "admin@admin.com", "password": "123456"},
  {"email": "invitado@invitado.com", "password": "123456"},
  {"email": "usuario@usuario.com", "password": "123456"},
  {"email": "anonimo@anonimo.com", "password": "123456"},
  {"email": "tester@tester.com", "password": "123456"},
];
final InputDecoration kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black.withOpacity(0.3), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: HexColor('d2e69c'), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
