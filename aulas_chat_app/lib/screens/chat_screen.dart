import 'package:flutter/material.dart';
import '../constants.dart';

class Chat extends StatefulWidget {
  String aula;

  Chat({this.aula});

  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                ),
                child: Center(
                  child: Text(
                    widget.aula,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/back.png'),
                      repeat: ImageRepeat.repeat),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(color: Colors.grey, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
