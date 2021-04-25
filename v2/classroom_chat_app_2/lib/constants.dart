import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';

final kSendButtonTextStyle = TextStyle(
  color: HexColor("28b5b5"),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Escribe tu mensaje aquí...',
  border: InputBorder.none,
);

final kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: HexColor("8fd9a8"), width: 2.0),
  ),
);

final InputDecoration kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black.withOpacity(0.3), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: HexColor('d2e69c'), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

enum classroom { a, b }

const kUsers = [
  {"email": "", "password": ""},
  {"email": "admin@admin.com", "password": "123456"},
  {"email": "invitado@invitado.com", "password": "123456"},
  {"email": "usuario@usuario.com", "password": "123456"},
  {"email": "anonimo@anonimo.com", "password": "123456"},
  {"email": "tester@tester.com", "password": "123456"},
];
