import 'package:flutter/material.dart';
import '../constants.dart';
import '../classes/user.dart';
import 'package:date_format/date_format.dart';
import '../classes/message_model.dart';
import '../services/login_service.dart';

int count = 0;

class Message extends StatefulWidget {
  User user;
  DateTime dateTime;
  String content;
  String label;
  bool isFromLoggedUser;
  MessageModel message;

  void formatLabel() {
    String date = formatDate(this.dateTime, [yyyy, '-', M, '-', dd]);
    String time = formatDate(this.dateTime, [HH, ':', nn]);

    this.label = '$date $time | ${message.user}';
  }

  Message({this.message}) {
    this.dateTime = message.timestamp.toDate();
    this.content = message.message;
    this.isFromLoggedUser = "admin@admin.com" == message.user;
    formatLabel();
  }

  @override
  State<StatefulWidget> createState() {
    return _MessageState();
  }
}

class _MessageState extends State<Message> {
  List<Expanded> buildMessageBlock() {
    Expanded textBlock = Expanded(
      flex: 7,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[500],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: kMessageDateTextStyle,
              ),
              Text(
                widget.content,
                style: kMessageTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
    Expanded emptyBlock = Expanded(
      flex: 2,
      child: ColoredBox(
        color: Colors.transparent,
        child: Text(""),
      ),
    );

    return widget.isFromLoggedUser
        ? [emptyBlock, textBlock]
        : [textBlock, emptyBlock];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          children: buildMessageBlock(),
        ),
      ),
    );
  }
}
