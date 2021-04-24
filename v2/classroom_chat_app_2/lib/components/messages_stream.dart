import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/message_model.dart';
import 'package:flash_chat/services/chat_service.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessagesStream extends StatelessWidget {
  Stream<QuerySnapshot> stream;

  MessagesStream({@required this.stream});

  buildListItem(DocumentSnapshot document) {
    Message obj = Message.fromJson(document.data());
    return MessageBubble(message: obj);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.docs;
          print("MESSAGESSS $messages");
          final list = <Widget>[];
          for (var m in messages) list.add(buildListItem(m));
          return Expanded(
              child: ListView(
                  reverse: true, padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0), children: list));
        }
        return Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ));
      },
    );
  }
}
