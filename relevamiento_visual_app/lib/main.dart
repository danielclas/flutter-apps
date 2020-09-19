import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relevamiento Visual',
      theme: ThemeData.dark().copyWith(errorColor: Colors.white),
      home: LoginPage(),
    );
  }
}
