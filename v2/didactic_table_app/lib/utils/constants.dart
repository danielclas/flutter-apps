import 'package:flutter/material.dart';

import 'hex_color.dart';

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
    top: BorderSide(color: HexColor("ededd0"), width: 2.0),
  ),
);

final InputDecoration kTextFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black.withOpacity(0.3), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: HexColor('ededd0'), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kUsers = [
  {"email": "", "password": ""},
  {"email": "admin@admin.com", "password": "123456"},
  {"email": "invitado@invitado.com", "password": "123456"},
  {"email": "usuario@usuario.com", "password": "123456"},
  {"email": "anonimo@anonimo.com", "password": "123456"},
  {"email": "tester@tester.com", "password": "123456"},
];

final kUserIcons = [
  FloatingActionButton(
    onPressed: () {},
    backgroundColor: Color(0xff8BC34A),
    child: Icon(Icons.person),
    heroTag: "btn2",
  ),
  FloatingActionButton(
    onPressed: () {},
    backgroundColor: Color(0xff8BC34A),
    child: Icon(Icons.person),
    heroTag: "btn3",
  ),
  FloatingActionButton(
    onPressed: () {},
    backgroundColor: Color(0xff8BC34A),
    child: Icon(Icons.person),
    heroTag: "btn4",
  ),
  FloatingActionButton(
    onPressed: () {},
    backgroundColor: Color(0xff8BC34A),
    child: Icon(Icons.person),
    heroTag: "btn5",
  ),
  FloatingActionButton(
    onPressed: () {},
    backgroundColor: Color(0xff8BC34A),
    child: Icon(Icons.person),
    heroTag: "btn6",
  ),
  FloatingActionButton(
    onPressed: () {},
    backgroundColor: Color(0xff8BC34A),
    child: Icon(Icons.person),
    heroTag: "btn7",
  ),
];
