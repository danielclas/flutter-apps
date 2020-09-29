import 'package:carga_credito_app/classes/credit.dart';
import 'package:carga_credito_app/services/login_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/user.dart';

class CreditService {
  static FirebaseFirestore firestore;
  static Credit credit;

  static Future<void> getCredits() async {
    if (LoginService.firestore == null) {
      await Firebase.initializeApp();
      firestore = FirebaseFirestore.instance;
    } else {
      firestore = LoginService.firestore;
    }

    //String user = LoginService.user.correo;

    var result = await firestore
        .collection('credits')
        .where('user', isEqualTo: "admin@admin.com")
        .get();

    if (result.docs.length >= 1) {
      credit = Credit.fromJson(result.docs.first.data());
    }

    return;
  }

  static Future<void> putCredits() async {}
}
