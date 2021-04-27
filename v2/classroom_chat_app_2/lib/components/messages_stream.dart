import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/message_model.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/utils/date_parser.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';
import '../utils/extension_methods.dart';
import 'date_bubble.dart';
import 'message_bubble.dart';

class MessagesStream {
  static DateTime previousDate;

  static List buildListItem(DocumentSnapshot document) {
    Message obj = Message.fromJson(document.data());
    final list = [];
    if (DateParser.areDifferentDay(obj.timestamp.toDate(), previousDate)) {
      previousDate = obj.timestamp.toDate();
      list.add(DateBubble(date: obj.timestamp.toDate()));
    }

    list.add(MessageBubble(message: obj));
    return list;
  }

  static Widget buildList(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      final messages = snapshot.data.docs;
      final list = <Widget>[];
      for (var m in messages) {
        final temp = MessagesStream.buildListItem(m);
        for (var t in temp) list.add(t);
      }
      MessagesStream.previousDate = null;
      return ListView(
          controller: ChatScreen.controller,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
          children: list);
    }
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: HexColor('d2e69c'),
    ));
  }
}
