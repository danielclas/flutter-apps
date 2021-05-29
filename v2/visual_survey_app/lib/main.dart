import 'package:flutter/material.dart';
import 'package:visual_survey_app/screens/home_screen.dart';
import 'package:visual_survey_app/screens/loading_screen.dart';
import 'package:visual_survey_app/screens/section_screen.dart';
import 'package:visual_survey_app/screens/welcome_screen.dart';
import 'package:visual_survey_app/services/firebase_service.dart';
import 'package:visual_survey_app/services/pictures_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.init();
  PictureService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: LoadingScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          SectionScreen.id: (context) => SectionScreen(),
          LoadingScreen.id: (context) => LoadingScreen(),
        },
        debugShowCheckedModeBanner: false);
  }
}
