import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.sender, this.isFromCurrentUser});

  final String text, sender;
  final bool isFromCurrentUser;

  BorderRadiusGeometry getRadiusGeometry() {
    Radius topRight = Radius.circular(this.isFromCurrentUser ? 0 : 30.0);
    Radius topLeft = Radius.circular(this.isFromCurrentUser ? 30.0 : 0);
    return BorderRadius.only(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isFromCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
              elevation: 5.0,
              borderRadius: getRadiusGeometry(),
              color: Colors.lightBlueAccent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  '$text from $sender',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              )),
        ],
      ),
    );
  }
}
