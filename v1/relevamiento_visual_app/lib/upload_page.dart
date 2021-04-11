import 'dart:async';
import 'dart:io';
import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:relevamiento_visual_app/services/pictures_service.dart';
import 'constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alert/alert.dart';

class UploadPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadPageState();
  }
}

class _UploadPageState extends State<UploadPage> {
  File imageFile;
  bool showSpinner = false;
  ImagePicker picker = ImagePicker();
  StorageUploadTask task;
  Image image;

  Future<void> pickImage(ImageSource source) async {
    final selected = await picker.getImage(source: source);

    setState(() {
      showSpinner = true;
    });

    setState(() {
      showSpinner = false;
      imageFile = File(selected.path);
      image = Image.file(imageFile);
    });
  }

  void discard() {
    PictureService.getAllPictures();

    setState(() {
      image = null;
      imageFile = null;
      showSpinner = false;
      task = null;
    });
  }

  void upload() async {
    setState(() {
      task = PictureService.uploadPicture(imageFile);
    });
  }

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
                child: image == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: showSpinner
                            ? [
                                SpinKitFadingCube(
                                  color: Colors.yellow[400],
                                  size: 100,
                                ),
                              ]
                            : [
                                Icon(Icons.camera),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                ),
                                Text("Presiona para tomar una foto"),
                              ],
                      )
                    : image,
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
              margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
              /*child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: LinearProgressIndicator(
                  value: 0.7,
                  minHeight: 10,
                ),
              ),*/
              child: task == null
                  ? null
                  : StreamBuilder<StorageTaskEvent>(
                      stream: task.events,
                      builder: (context, snapshot) {
                        var event = snapshot?.data?.snapshot;

                        if (task.isComplete) {
                          Timer(
                              Duration(seconds: 4),
                              () => {
                                    discard(),
                                    Alert(
                                            message:
                                                'La imagen fue cargada correctamente')
                                        .show()
                                  });
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (task.isInProgress) FadingText('Cargando...'),
                            if (task.isComplete) Text("Completada!"),
                          ],
                        );
                      },
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
                onPressed: image == null ? null : upload,
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
                onPressed: image == null ? null : discard,
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
