import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:visual_survey_app/models/picture.dart';
import 'package:visual_survey_app/services/firebase_service.dart';

class PictureService {
  static FirebaseStorage storage;
  static String storageBucket = "gs://pps-apps-b0fb3.appspot.com";
  static List<Picture> pictures = [];
  static String basePath = 'gs://pps-apps-b0fb3.appspot.com/images/';

  static void initService() async {
    if (storage == null)
      storage = FirebaseFirestore.instanceFor(app: FirebaseService.instance) as FirebaseStorage;
  }

  static uploadPicture(File file) {
    initService();

    String timestamp = DateTime.now().second.toString();
    String user = FirebaseService.loggedInUser.substring(0, FirebaseService.loggedInUser.indexOf('@'));
    String path = '$user-$timestamp.jpg';

    addToCollection(user, path);

    try {
      final firebaseStorageRef = FirebaseStorage.instance.ref().child('images/$path');
      return firebaseStorageRef.putFile(file);
    } catch (e) {
      return null;
    }
  }

  static Future<void> votePicture(String user, String path, bool like) async {
    final result =
        await FirebaseService.firestore.collection('images').where('path', isEqualTo: path).getDocuments();

    if (result != null) {
      final doc = result.documents[0];
      final arr = doc.data['usersVoted'] ?? [];
      int likes = doc.data['likes'] ?? 0;
      int dislikes = doc.data['dislikes'] ?? 0;

      arr.add(user);

      await FirebaseService.firestore.collection('images').document(doc.documentID).setData({
        'likes': like ? ++likes : likes,
        'dislikes': !like ? ++dislikes : dislikes,
        'usersVoted': arr,
      });
    }
  }

  static Future<void> addToCollection(String user, String path) async {
    await FirebaseService.firestore
        .collection('images')
        .add({'dislikes': 0, 'likes': 0, 'path': path, 'usersVoted': [], 'date': DateTime.now()});
  }

  static Future<void> getAllPictures() async {
    initService();
    final result = await FirebaseService.firestore.collection('images').getDocuments();

    pictures = [];

    result.documents.forEach((element) async {
      final p = await documentToPicture(element);
      pictures.add(p);
    });
  }

  static Future<Picture> documentToPicture(DocumentSnapshot document) async {
    final url = await storage.ref().child('images/' + document.get('path')).getDownloadURL();
    return Picture.fromJson(document.data(), url.toString());
  }
}
