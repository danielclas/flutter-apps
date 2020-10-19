import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).copyWith(
          hintColor: Colors.red[500],
          highlightColor: Colors.red[500],
          accentColor: Colors.red[500]),
      home: LoginPage(),
    );
  }
}
