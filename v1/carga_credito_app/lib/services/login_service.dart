import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/user.dart';

class LoginService {
  static FirebaseFirestore firestore;
  static User user;

  static Future<bool> loginUser(String email, String password) async {
    if (firestore == null) {
      await Firebase.initializeApp();
      firestore = FirebaseFirestore.instance;
    }

    bool exists = false;
    var result = await firestore
        .collection('users')
        .where('correo', isEqualTo: email)
        .where('clave', isEqualTo: password)
        .get();

    result.docs.forEach((element) {
      print(element.data().toString());
    });

    if (result.docs.length >= 1) {
      exists = true;
      user = User.fromJson(result.docs.first.data());
    }

    return exists;
  }
}
