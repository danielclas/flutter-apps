import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseService.firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var m in messages) {
            final text = m.data()['text'];
            final sender = m.data()['sender'];
            final isFromCurrentUser =
                FirebaseService.loggedInUser.email == sender;
            final widget = MessageBubble(
              text: text,
              sender: sender,
              isFromCurrentUser: isFromCurrentUser,
            );
            messageBubbles.add(widget);
          }
          return Expanded(
              child: ListView(
                  reverse: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  children: messageBubbles));
        }
        return Center(
            child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ));
      },
    );
  }
}
