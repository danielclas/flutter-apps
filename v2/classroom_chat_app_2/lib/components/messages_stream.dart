import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/models/message_model.dart';
import 'package:flash_chat/utils/date_parser.dart';

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
}
