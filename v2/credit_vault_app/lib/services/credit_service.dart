import 'package:credit_vault_app/model/credit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

class CreditService {
  static Credit credit;

  static Future<void> getCredits() async {
    String user = FirebaseService.loggedInUser.email;

    var result = await FirebaseService.firestore.collection('credits').where('user', isEqualTo: user).get();

    if (result.docs.length >= 1) {
      credit = Credit.fromJson(result.docs.first.data());
    } else {
      credit = null;
    }

    return;
  }

  static bool canPutCredit(int amount) {
    if (credit == null) return true;

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
    String user = FirebaseService.loggedInUser.email;

    var result = await FirebaseService.firestore.collection('credits').where('user', isEqualTo: user).get();

    if (result.docs.length >= 1) {
      var arr = credit.credits;

      if (clear) {
        arr = [];
      } else {
        arr.add(amount);
      }

      await FirebaseService.firestore
          .collection('credits')
          .doc(result.docs.first.id)
          .update({"credits": arr});
    } else {
      print("Entro al else porque 0 es menor");
      await FirebaseService.firestore.collection('credits').add({
        'credits': [amount],
        'user': user
      });
    }
  }
}
