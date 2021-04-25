import 'package:flash_chat/models/message_model.dart';
import 'package:flash_chat/services/firebase_service.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MessageBubble extends StatelessWidget {
  MessageBubble({this.message});

  final Message message;
  bool isFromCurrentUser = true;

  formatSender() =>
      isFromCurrentUser ? '' : '${this.message.sender.toString().substring(0, this.message.sender.indexOf('@'))} |';
  formatTime() => DateFormat('HH:mm').format(message.timestamp.toDate());

  BorderRadiusGeometry getRadiusGeometry() {
    Radius topRight = Radius.circular(this.isFromCurrentUser ? 0 : 30.0);
    Radius topLeft = Radius.circular(this.isFromCurrentUser ? 30.0 : 0);
    return BorderRadius.only(
        topLeft: topLeft, topRight: topRight, bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0));
  }

  @override
  Widget build(BuildContext context) {
    isFromCurrentUser = FirebaseService.loggedInUser.email == message.sender;
    print(message.toJson());
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        crossAxisAlignment: isFromCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
              elevation: 5.0,
              borderRadius: getRadiusGeometry(),
              color: isFromCurrentUser ? HexColor("28b5b5") : HexColor("8fd9a8"),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: isFromCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${formatSender()} ${formatTime()}",
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        '${message.content}',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
