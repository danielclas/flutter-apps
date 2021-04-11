import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  String email;
  String password;

  LoginCard(this.email, this.password);

  @override
  State<StatefulWidget> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            decoration: BoxDecoration(
              color: Colors.teal[300],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.supervised_user_circle),
          ),
          Text(
            widget.email.toString(),
            style: TextStyle(fontSize: 25),
          ),
          Text(
            '•••••',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
