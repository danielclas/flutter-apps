import 'package:flash_chat/utils/date_parser.dart';
import 'package:flash_chat/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateBubble extends StatelessWidget {
  DateBubble({this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black26,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                "${DateParser.formatDate(date)}",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ))
      ],
    );
  }
}
