import 'package:didactic_table_app/components/image_tiles.dart';
import 'package:didactic_table_app/components/slidable_item.dart';
import 'package:didactic_table_app/services/firebase_service.dart';
import 'package:didactic_table_app/services/tts_service.dart';
import 'package:didactic_table_app/utils/constants.dart';
import 'package:didactic_table_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import '../utils/extension_methods.dart';
import '../components/custom_slider.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedLanguage = 0;
  int selectedSection = 0;
  int selectedItem = 0;

  void switchSection() {
    setState(() {
      selectedSection = selectedSection + 1 < 3 ? selectedSection + 1 : 0;
    });
  }

  void switchLanguage() {
    setState(() {
      selectedLanguage = selectedLanguage + 1 < 3 ? selectedLanguage + 1 : 0;
      Tts.setTtsLanguage(kTtsLanguages[selectedLanguage]);
    });
  }

  void switchItem(index, b) => setState(() => selectedItem = index);

  void speak(section, language, item) => Tts.speak(kSections[section][language][item]);

  String getUserName() =>
      FirebaseService.loggedInUser.email.substring(0, FirebaseService.loggedInUser.email.indexOf('@'));

  @override
  void initState() {
    Tts.setTtsLanguage(kTtsLanguages[0]);
    super.initState();
  }

  List buildImageList(List<String> section) =>
      section.map((e) => SlidableSquare(child: Image(image: AssetImage('images/$e')))).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla didactica'),
        centerTitle: true,
        backgroundColor: HexColor('f38181'),
      ),
      body: Center(
        child: Container(
            decoration: BoxDecoration(color: HexColor('fce38a')),
            child: context.height < context.width
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImageTiles(section: selectedSection, language: selectedLanguage, onTap: this.speak),
                      context.height < context.width
                          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              GestureDetector(
                                  onTap: switchSection,
                                  child: SlidableSquare(
                                      child: Image(image: AssetImage('images/${kIcons[selectedSection]}')))),
                              GestureDetector(
                                  onTap: switchLanguage,
                                  child: SlidableSquare(
                                      child: Image(image: AssetImage('images/${kFlags[selectedLanguage]}'))))
                            ])
                          : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              GestureDetector(
                                  onTap: switchSection,
                                  child: SlidableSquare(
                                      child: Image(image: AssetImage('images/${kIcons[selectedSection]}')))),
                              GestureDetector(
                                  onTap: switchLanguage,
                                  child: SlidableSquare(
                                      child: Image(image: AssetImage('images/${kFlags[selectedLanguage]}'))))
                            ]),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImageTiles(section: selectedSection, language: selectedLanguage, onTap: this.speak),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        GestureDetector(
                            onTap: switchSection,
                            child: SlidableSquare(
                                child: Image(image: AssetImage('images/${kIcons[selectedSection]}')))),
                        GestureDetector(
                            onTap: switchLanguage,
                            child: SlidableSquare(
                                child: Image(image: AssetImage('images/${kFlags[selectedLanguage]}'))))
                      ]),
                    ],
                  )),
      ),
    );
  }
}
