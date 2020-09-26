import 'package:aulas_chat_app/classes/message_model.dart';
import 'package:aulas_chat_app/services/login_service.dart';
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

  static void writeMessage(String content) async {
    MessageModel message = MessageModel(
        message: content,
        timestamp: Timestamp.now(),
        user: LoginService.user.correo);

    await firestore.collection(aula).add(message.toJson());
  }

  static Stream<QuerySnapshot> stream() {
    return firestore.collection(aula).snapshots();
  }
}
