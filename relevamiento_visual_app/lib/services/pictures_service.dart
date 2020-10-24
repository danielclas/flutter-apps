import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:relevamiento_visual_app/classes/picture_model.dart';
import 'package:relevamiento_visual_app/services/login_service.dart';

class PictureService {
  static FirebaseFirestore firestore;
  static FirebaseStorage storage;
  static String storageBucket = "gs://pps-apps-aa8cf.appspot.com";
  static List<Picture> pictures = [];
  static String basePath = 'gs://pps-apps-aa8cf.appspot.com/images/';

  static void initService() async {
    if (firestore == null) {
      await Firebase.initializeApp();
      firestore = FirebaseFirestore.instance;
    }

    if (storage == null) {
      storage = FirebaseStorage(storageBucket: storageBucket);
    }

    await getAllPictures();
  }

  static StorageUploadTask uploadPicture(File file) {
    initService();

    String timestamp = Timestamp.now().seconds.toString();
    String user = LoginService.user.correo
        .substring(0, LoginService.user.correo.indexOf('@'));
    String path = '$user-$timestamp.jpg';

    addToCollection(user, path);

    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$path');

    return firebaseStorageRef.putFile(file);
  }

  static Future<void> votePicture(String user, String path, bool like) async {
    var result = await FirebaseFirestore.instance
        .collection('images')
        .where('path', isEqualTo: path)
        .get();

    if (result.docs.length >= 1) {
      var ref = result.docs.first;
      var arr = ref.data()['usersVoted'];
      var likes = ref.data()['likes'];
      var dislikes = ref.data()['dislikes'];

      if (arr == null || arr.length == 0)
        arr = [user];
      else
        arr.push(user);

      if (like)
        likes++;
      else
        dislikes++;

      await FirebaseFirestore.instance.collection('images').doc(ref.id).update({
        'likes': likes,
        'dislikes': dislikes,
        'usersVoted': arr,
      });
    }
  }

  static Future<void> getAllPictures() async {
    var result = await FirebaseFirestore.instance.collection('images').get();
    var ref = await FirebaseStorage.instance.ref();

    pictures = [];

    result.docs.forEach((element) async {
      var durl =
          await ref.child('images/' + element.data()['path']).getDownloadURL();
      String url = durl.toString();
      Picture temp = Picture.fromJson(element.data(), url);
      pictures.add(temp);
    });
  }

  static Future<void> addToCollection(String user, String path) async {
    await FirebaseFirestore.instance.collection('images').add({
      'dislikes': 0,
      'likes': 0,
      'path': path,
      'usersVoted': [],
      'date': DateTime.now()
    });
  }
}
