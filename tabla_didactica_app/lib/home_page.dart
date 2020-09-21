import 'package:flutter/material.dart';
import 'constants.dart';
import 'components/list_item.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int selectedLanguage = 0;
  int selectedSection = 0;
  var section = kSections;

  void switchLanguage() {
    selectedLanguage = selectedLanguage == 2 ? 0 : selectedLanguage + 1;
  }

  void switchSection() {
    selectedSection = selectedSection == 2 ? 0 : selectedSection + 1;
  }

  List<Widget> makeRows() {
    List<Widget> list = [];

    list.add(Expanded(
        child: SizedBox.expand(child: Center(child: Text("Animales")))));

    for (int i = 0; i < 5; i++) {
      list.add(ListItem(
          image: Image(image: AssetImage('images/back.png')),
          label: Text(kSections[selectedSection][selectedLanguage][i]),
          color: kBoxColors[i]));
    }

    return list;
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
                child: Icon(Icons.save),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
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
                child: Icon(Icons.close),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
            title: Text('Relevamiento visual',
                style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'))),
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
