import 'package:flash_chat/utils/date_parser.dart';
import 'package:flutter/material.dart';
import '../utils/extension_methods.dart';

class DateBubble extends StatelessWidget {
  DateBubble({this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 0.5.percentOf(context.height), bottom: 1.percentOf(context.height)),
          child: Material(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black26,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 1.5.percentOf(context.height), horizontal: 5.percentOf(context.width)),
                child: Text(
                  "${DateParser.formatDate(date)}",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              )),
        )
      ],
    );
  }
}
