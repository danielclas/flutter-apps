import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String content;
  Timestamp timestamp;
  String sender;

  Message({this.content, this.timestamp, this.sender});

  Message.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        timestamp = json['timestamp'],
        sender = json['sender'];

  Map<String, dynamic> toJson() => {
        'content': content,
        'timestamp': timestamp,
        'user': sender,
      };
}
