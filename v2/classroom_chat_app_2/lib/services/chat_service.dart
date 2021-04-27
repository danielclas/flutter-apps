import 'dart:convert';

import 'package:flash_chat/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'firebase_service.dart';

class ChatService {
  final String collection;

  ChatService({@required this.collection});

  getMessages() =>
      FirebaseService.firestore.collection(collection).orderBy('timestamp', descending: false).snapshots();
  addMessage(Message message) => FirebaseService.firestore.collection(collection).add(message.toJson());
}
