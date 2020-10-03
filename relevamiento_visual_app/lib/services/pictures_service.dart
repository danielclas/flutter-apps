import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PictureService {
  static FirebaseFirestore firestore;
  static FirebaseStorage storage;
  static String storageBucket = "gs://pps-apps-aa8cf.appspot.com";

  static void initService() async {
    if (firestore == null) {
      await Firebase.initializeApp();
      firestore = FirebaseFirestore.instance;
    }

    if (storage == null) {
      print("Is null");
      storage = FirebaseStorage(storageBucket: storageBucket);
      print("Here");
    }
  }

  static StorageUploadTask uploadPicture(File file) {
    initService();

    String timestamp = Timestamp.now().toString();
    String path = 'images/$timestamp.jpg';

    //TODO register on collection 'picture' how is uploading it

    return FirebaseStorage.instance.ref().child(path).putFile(file);
  }
}
