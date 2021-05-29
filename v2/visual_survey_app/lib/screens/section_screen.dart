import 'package:flutter/material.dart';
import 'package:visual_survey_app/components/upload_component.dart';
import 'package:visual_survey_app/components/voting_component.dart';
import 'package:visual_survey_app/services/pictures_service.dart';
import 'package:visual_survey_app/utils/hex_color.dart';

class SectionScreen extends StatefulWidget {
  static final String id = "SectionScreen";

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  int bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('323232'),
        title: Text('${PictureService.niceThings ? 'Cosas lindas' : 'Cosas feas'}'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => bottomNavBarIndex = index),
        currentIndex: bottomNavBarIndex,
        selectedLabelStyle: TextStyle(color: Colors.black),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_a_photo,
              color: HexColor('323232'),
            ),
            label: "Subir foto",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: HexColor('323232'),
              ),
              label: "Listado")
        ],
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), scale: 0.1, repeat: ImageRepeat.repeat),
          ),
        ),
        Center(child: bottomNavBarIndex == 0 ? UploadComponent() : VotingComponent())
      ]),
    );
  }
}
