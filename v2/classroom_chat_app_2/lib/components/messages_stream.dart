import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/message_model.dart';
import 'package:flash_chat/services/chat_service.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'date_bubble.dart';
import 'message_bubble.dart';

class MessagesStream extends StatelessWidget {
  ChatService chatService;
  DateTime previousDate;

  MessagesStream({@required this.chatService});

  areDifferentDay(DateTime a, DateTime b) {
    if (a == null || b == null) return true;
    return a.year != b.year || a.month != b.month || a.day != b.day;
  }

  List buildListItem(DocumentSnapshot document) {
    Message obj = Message.fromJson(document.data());
    final list = [];
    if (areDifferentDay(obj.timestamp.toDate(), previousDate)) {
      previousDate = obj.timestamp.toDate();
      list.add(DateBubble(date: obj.timestamp.toDate()));
    }

    list.add(MessageBubble(message: obj));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatService.getMessages(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.docs;
          final list = <Widget>[];
          for (var m in messages) {
            final temp = buildListItem(m);
            for (var t in temp) list.add(t);
          }
          previousDate = null;
          return Expanded(
              child: ListView(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0), children: list));
        }
        return Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ));
      },
    );
  }
}
