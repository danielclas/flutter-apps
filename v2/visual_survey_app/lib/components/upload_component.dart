import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  Image image;

  final Widget spinner = CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    strokeWidth: 2,
  );

  Future<void> pickImage(ImageSource source) async {
    final selected = await picker.getImage(source: source, imageQuality: 0);

    setState(() {
      showSpinner = true;
      imageFile = File(selected.path);
      image = Image.file(imageFile);
      Timer(Duration(seconds: 3), () {
        setState(() {
          showSpinner = false;
        });
      });
    });
  }

  void discard() {
    setState(() {
      image = null;
      imageFile = null;
      showSpinner = false;
    });
  }

  void upload() async {
    setState(() {
      showSpinner = true;
      PictureService.uploadPicture(imageFile);
      imageFile = null;
      image = null;
      Timer(Duration(seconds: 3), () {
        setState(() {
          showSpinner = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Su foto fue subida correctamente')));
        });
      });
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
              child: showSpinner
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [spinner],
                    )
                  : image != null
                      ? image
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera),
                            Text("Presiona para tomar una foto"),
                          ],
                        ),
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white.withOpacity(0.9), width: 2),
              ),
            ),
          ),
          Container(child: null),
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
