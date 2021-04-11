import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kTitlesTextStyle = GoogleFonts.montserrat(
    fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);

final kMessageTextStyle =
    GoogleFonts.montserrat(fontSize: 15.0, color: Colors.white);
final kMessageDateTextStyle = GoogleFonts.montserrat(
    fontSize: 12, color: Colors.white, decoration: TextDecoration.underline);
final kAulaTitleTextStyle = GoogleFonts.montserrat(
    fontSize: 20, color: Colors.white, fontStyle: FontStyle.italic);

const kUsers = [
  {"correo": "admin@admin.com", "clave": "1111"},
  {"correo": "invitado@invitado.com", "clave": "2222"},
  {"correo": "usuario@usuario.com", "clave": "3333"},
  {"correo": "anonimo@anonimo.com", "clave": "4444"},
  {"correo": "tester@tester.com", "clave": "5555"},
  {"correo": "", "clave": ""}
];

const kAccentColors = [
  Colors.red,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.grey,
  Colors.green
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

enum Aula { a, b }
