import 'package:flutter/material.dart';
import 'package:users_crud_app/screens/home_screen.dart';
import 'package:users_crud_app/screens/loading_screen.dart';
import 'package:users_crud_app/screens/welcome_screen.dart';
import 'package:users_crud_app/services/firebase_service.dart';
import 'package:users_crud_app/utils/hex_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.dark,
            primaryColor: HexColor('903749'),
            accentColor: HexColor('e84545'),
            inputDecorationTheme: InputDecorationTheme(
                suffixStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                focusColor: HexColor('e84545'),
                errorStyle: TextStyle(color: Colors.white, height: 0))),
        initialRoute: LoadingScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          LoadingScreen.id: (context) => LoadingScreen()
        },
        debugShowCheckedModeBanner: false);
  }
}
