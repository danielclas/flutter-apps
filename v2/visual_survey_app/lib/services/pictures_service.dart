import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visual_survey_app/models/picture.dart';
import 'package:visual_survey_app/services/firebase_service.dart';

class PictureService {
  static List<Picture> pictures = [];
  static String path = '';
  static bool niceThings = true;

  static init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String newPath = join(documentDirectory.path, 'collections.txt');

    final file = File(newPath);
    final exists = await file.exists();
    if (!exists) {
      file.writeAsString('[]');
    }

    path = newPath;
  }

  static uploadPicture(File file) async {
    String timestamp = DateTime.now().second.toString();
    String user = FirebaseService.shortUser;
    String path = '$user-$timestamp.jpg';
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String newPath = join(documentDirectory.path, path);

    file.copySync(newPath);
    addToCollection(user, newPath);
  }

  static votePicture(Picture picture, bool like) {
    final pictures = getAllPictures();
    for (int i = 0; i < pictures.length; i++) {
      final p = pictures[i];
      if (p.path == picture.path) {
        if (like)
          p.likes++;
        else
          p.dislikes++;
        p.usersVoted.add(FirebaseService.shortUser);
      }
    }

    File(path).writeAsString(jsonEncode(pictures));
  }

  static addToCollection(String user, String filePath) {
    final picture = Picture(0, 0, filePath, []);
    final pictures = jsonDecode(File(path).readAsStringSync());

    pictures.add(picture);
    File(path).writeAsString(jsonEncode(pictures));
  }

  static List<Picture> getAllPictures() {
    final list = jsonDecode(File(path).readAsStringSync());
    final List<Picture> pictures = [];

    for (var i = 0; i < list.length; i++) {
      pictures.add(Picture.fromJson(list[i]));
    }
    print(pictures);
    return pictures;
  }
}
