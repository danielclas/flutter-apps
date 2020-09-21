import 'package:flutter/material.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int selectedLanguage = 0;
  String selectedSection = "Animales";

  void switchLanguage() {
    selectedLanguage = selectedLanguage == 2 ? 0 : selectedLanguage + 1;
  }

  List<Widget> makeRows() {
    List<Widget> list = [];

    list.add(Expanded(
        child: SizedBox.expand(child: Center(child: Text(selectedSection)))));

    for (int i = 0; i < 4; i++) {
      String color = kColors[0][i];
      list.add(Expanded(
          child: SizedBox.expand(
              child: DecoratedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(kAnimals[0][i]), Text(kColors[0][i])],
        ),
        decoration: BoxDecoration(color: Colors.red),
      ))));
    }

    return list;
  }

  @override
  void initState() {
    selectedLanguage = "English";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              bottom: 80.0,
              right: 10.0,
              child: FloatingActionButton(
                heroTag: 'save',
                onPressed: () {
                  setState(() {});
                },
                child: Icon(Icons.save),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: makeRows(),
            ),
          ),
        ));
  }
}
