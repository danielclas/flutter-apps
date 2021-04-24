import 'package:flash_chat/constants.dart';
import 'package:flash_chat/models/message_model.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';
import 'firebase_service.dart';

class ChatService {
  final String collection;

  ChatService({@required this.collection});

  getMessages() => FirebaseService.firestore.collection("classroom-a").snapshots();
  addMessage(Message message) => FirebaseService.firestore.collection('classroom-a').add(message.toJson());
}
