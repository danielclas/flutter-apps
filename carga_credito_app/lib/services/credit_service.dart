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

    String user = LoginService.user.correo;

    var result = await firestore
        .collection('credits')
        .where('user', isEqualTo: user)
        .get();

    if (result.docs.length >= 1) {
      credit = Credit.fromJson(result.docs.first.data());
    }

    return;
  }

  static bool canPutCredit(int amount) {
    bool contains = credit.credits.contains(amount);
    bool userIsAdmin = credit.user.contains("admin");

    if (!contains) {
      return true;
    } else if (!userIsAdmin) {
      return false;
    }

    return credit.credits.where((c) => c == amount).length <= 1;
  }

  static Future<void> putCredits(int amount, bool clear) async {
    if (LoginService.firestore == null) {
      await Firebase.initializeApp();
      firestore = FirebaseFirestore.instance;
    } else {
      firestore = LoginService.firestore;
    }

    String user = LoginService.user.correo;

    var result = await firestore
        .collection('credits')
        .where('user', isEqualTo: user)
        .get();

    if (result.docs.length >= 1) {
      var arr = credit.credits;

      if (clear) {
        arr = [];
      } else {
        arr.add(amount);
      }

      await firestore
          .collection('credits')
          .doc(result.docs.first.id)
          .update({"credits": arr});
    } else {
      await firestore.collection('credits').add({
        'credits': [amount],
        'user': user
      });
    }
  }
}
