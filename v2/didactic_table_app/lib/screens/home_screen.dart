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

  void switchLanguage(index, b) {
    selectedLanguage = index;
    Tts.setTtsLanguage(kTtsLanguages[selectedLanguage]);
  }

  void switchSection(index, b) => setState(() => selectedSection = index);

  void switchItem(index, b) => setState(() => selectedItem = index);

  void speak() => Tts.speak(kSections[selectedSection][selectedLanguage][selectedItem]);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hola de nuevo, Admin!',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              CustomSlider(
                children: buildImageList(kFlags),
                handler: switchLanguage,
                height: 12.percentOf(context.height),
              ),
              CustomSlider(
                children: buildImageList(kSectionImages[selectedSection]),
                handler: switchItem,
                height: 27.percentOf(context.height),
              ),
              CustomSlider(
                children: buildImageList(kIcons),
                handler: switchSection,
                height: 12.percentOf(context.height),
              ),
              GestureDetector(
                onTap: speak,
                child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Container(
                        width: 40.percentOf(context.width),
                        decoration: BoxDecoration(
                            color: HexColor('f38181'),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(width: 2.percentOf(context.width), color: Colors.transparent)),
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Escuchar',
                            style: TextStyle(fontSize: 20),
                          ),
                        )))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
