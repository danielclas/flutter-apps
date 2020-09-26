import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String message;
  Timestamp timestamp;
  String user;

  MessageModel({this.message, this.timestamp, this.user});

  MessageModel.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        timestamp = json['timestamp'],
        user = json['user'];

  Map<String, dynamic> toJson() => {
        'message': message,
        'timestamp': timestamp,
        'user': user,
      };
}
