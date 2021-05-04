import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visual_survey_app/screens/section_screen.dart';
import '../utils/extension_methods.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relevamiento visual'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, SectionScreen.id),
              child: Container(
                color: Colors.red,
                child: SizedBox(
                  child: Center(child: Text('Cosas Lindas')),
                  width: 60.percentOf(context.width),
                  height: 40.percentOf(context.height),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, SectionScreen.id),
              child: Container(
                color: Colors.grey,
                child: SizedBox(
                  child: Center(child: Text('Cosas Feas')),
                  width: 60.percentOf(context.width),
                  height: 40.percentOf(context.height),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
