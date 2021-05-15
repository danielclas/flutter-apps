import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:visual_survey_app/screens/section_screen.dart';
import 'package:visual_survey_app/utils/hex_color.dart';
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
        backgroundColor: HexColor('323232'),
        title: Text('Relevamiento visual'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/background.png'), scale: 0.1, repeat: ImageRepeat.repeat),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SectionBox(label: 'Cosas lindas', image: 'nice-things-graphic.svg'),
                SizedBox(
                  height: 2.percentOf(context.height),
                ),
                SectionBox(label: 'Cosas feas', image: 'ugly-things-graphic.svg')
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SectionBox extends StatelessWidget {
  String label, image;

  SectionBox({this.label, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, SectionScreen.id),
      child: Material(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 5.percentOf(context.width), vertical: 5.percentOf(context.height)),
          decoration: BoxDecoration(color: HexColor('0d7377')),
          child: SizedBox(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
                ),
                Image(
                    height: 20.percentOf(context.height),
                    width: 40.percentOf(context.width),
                    image: Svg('images/$image')),
              ],
            )),
            width: 60.percentOf(context.width),
            height: 30.percentOf(context.height),
          ),
        ),
      ),
    );
  }
}
