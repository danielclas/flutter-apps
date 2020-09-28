import 'dart:io';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'constants.dart';

class CameraComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraComponentState();
  }
}

class _CameraComponentState extends State<CameraComponent> {
  File imageFile;
  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final selected = await picker.getImage(source: source);

    setState(() {
      if (selected != null) {
        imageFile = File(selected.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void discard() {
    setState(() {
      imageFile = null;
    });
  }

  void upload() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Relevamiento visual',
              style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'))),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/back.png'), repeat: ImageRepeat.repeat),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                pickImage(ImageSource.camera);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                child: imageFile == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          ),
                          Text("Presiona para tomar una foto"),
                        ],
                      )
                    : Image(
                        image: AssetImage(imageFile.path),
                      ),
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.9), width: 2),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: SizedBox(
                width: double.infinity,
                height: 5,
                child: ColoredBox(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            RaisedButton(
                onPressed: imageFile == null ? null : upload,
                child: BorderedText(
                  strokeWidth: 4.0,
                  strokeColor: Colors.black54,
                  child: Text(
                    "Subir foto",
                    style: kTitlesTextStyle.copyWith(
                        fontSize: 15, letterSpacing: 2.0),
                  ),
                ),
                color: ThemeData.dark().accentColor),
            RaisedButton(
                onPressed: imageFile == null ? null : discard,
                child: BorderedText(
                  strokeWidth: 4.0,
                  strokeColor: Colors.black54,
                  child: Text(
                    "Descartar",
                    style: kTitlesTextStyle.copyWith(
                        fontSize: 15, letterSpacing: 2.0),
                  ),
                ),
                color: ThemeData.dark().accentColor),
          ],
        ),
      ),
    );
  }
}
