import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/loading_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import './services/firebase_service.dart';
import 'screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  runApp(ClassroomChat());
}

class ClassroomChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: LoadingScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          LoadingScreen.id: (context) => LoadingScreen()
        },
        debugShowCheckedModeBanner: false);
  }
}
