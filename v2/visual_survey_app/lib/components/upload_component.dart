import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:visual_survey_app/components/rectangle_button.dart';
import 'package:visual_survey_app/services/pictures_service.dart';
import 'package:visual_survey_app/utils/hex_color.dart';
import '../utils/extension_methods.dart';

class UploadComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadComponentState();
  }
}

class _UploadComponentState extends State<UploadComponent> {
  File imageFile;
  bool showSpinner = false;
  ImagePicker picker = ImagePicker();
  UploadTask task;
  Image image;

  Future<void> pickImage(ImageSource source) async {
    final selected = await picker.getImage(source: source, imageQuality: 0);

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

  notifyTaskComplete() => Timer(
      Duration(seconds: 4),
      () => {
            discard(),
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('La imagen fue cargada correctamente')))
          });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              pickImage(ImageSource.camera);
            },
            child: Container(
              child: image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: showSpinner
                          ? [Text('...')]
                          : [
                              Icon(Icons.camera),
                              Text("Presiona para tomar una foto"),
                            ],
                    )
                  : image,
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
              ),
            ),
          ),
          Container(
            child: task == null
                ? null
                : StreamBuilder<TaskSnapshot>(
                    stream: task.snapshotEvents,
                    builder: (context, snapshot) {
                      task.whenComplete(() => notifyTaskComplete());

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [FadingText('Cargando...')],
                      );
                    },
                  ),
          ),
          Container(
            child: SizedBox(
              width: double.infinity,
              height: 5,
              child: ColoredBox(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 4.percentOf(context.height)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectangleButton(
                  onPressed: image == null ? null : upload,
                  text: 'Subir foto',
                  color: image == null ? Colors.grey : HexColor('14ffec'),
                  minWidth: 40.percentOf(context.width),
                ),
                SizedBox(height: 3.percentOf(context.height)),
                RectangleButton(
                  onPressed: image == null ? null : discard,
                  text: 'Descartar',
                  color: image == null ? Colors.grey : HexColor('14ffec'),
                  minWidth: 40.percentOf(context.width),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
