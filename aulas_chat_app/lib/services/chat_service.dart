import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/user.dart';
import 'package:aulas_chat_app/constants.dart';

class ChatService {
  static const String aulaA = 'amessages';
  static const String aulaB = 'bmessages';

  static FirebaseFirestore firestore;
  static String aula = aulaA;

  static void setAula(Aula temp) {
    aula = temp == Aula.a ? aulaA : aulaB;
  }

  static void initChatService() async {
    if (firestore == null) {
      await Firebase.initializeApp();
      firestore = FirebaseFirestore.instance;
    }
  }

  static Stream<QuerySnapshot> stream() {
    return firestore.collection(aula).snapshots();
  }
}
