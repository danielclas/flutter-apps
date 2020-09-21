import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String selectedLanguage;

  List<Widget> makeRows() {
    List<Widget> list = [];
    list.add(Text(selectedLanguage));
    list.add(ColoredBox(color: Colors.red));
    list.add(Text("UNO"));
    list.add(Text("UNO"));

    return list;
  }

  @override
  void initState() {
    selectedLanguage = Languages.English.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

enum Languages { English, Spanish, Portuguese }
