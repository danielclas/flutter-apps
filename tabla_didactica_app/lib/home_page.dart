import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'components/list_item.dart';
import './services/tts_service.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int selectedLanguage = 0;
  int selectedSection = 0;

  void switchLanguage() {
    selectedLanguage = selectedLanguage == 2 ? 0 : selectedLanguage + 1;
    Tts.setTtsLanguage(kTtsLanguages[selectedLanguage]);
  }

  void switchSection() {
    selectedSection = selectedSection == 2 ? 0 : selectedSection + 1;
  }

  List<Widget> makeRows() {
    List<Widget> list = [];

    list.add(Expanded(
        child: SizedBox.expand(
            child: Center(
                child: Text(kSectionLabels[selectedSection][selectedLanguage],
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 40.0))))));

    for (int i = 0; i < 5; i++) {
      String label = kSections[selectedSection][selectedLanguage][i];
      list.add(
        ListItem(
            image: Image(
                width: 70.0,
                height: 70.0,
                image:
                    AssetImage('images/${kSectionImages[selectedSection][i]}')),
            label: Text(
              label,
              style: TextStyle(fontSize: 20),
            ),
            color: kBoxColors[i]),
      );
    }

    return list;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              bottom: 80.0,
              left: 25.0,
              child: FloatingActionButton(
                  heroTag: 'save',
                  onPressed: () {
                    setState(() {
                      switchSection();
                    });
                  },
                  child: Image.asset('images/${kIcons[selectedSection]}')),
            ),
            Positioned(
              bottom: 10.0,
              left: 25.0,
              child: FloatingActionButton(
                heroTag: 'close',
                onPressed: () {
                  setState(() {
                    switchLanguage();
                  });
                },
                child: Image.asset('images/${kFlags[selectedLanguage]}'),
              ),
            ),
          ],
        ),
        appBar: AppBar(
            title: Text('Relevamiento visual',
                style: TextStyle(color: Colors.white))),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/back.png'), fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: makeRows(),
            ),
          ),
        ));
  }
}
