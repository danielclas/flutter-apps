import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/login_service.dart';

class UserBox extends StatefulWidget {
  final String user;
  final Color color;

  UserBox({this.user, this.color});

  String getUser() {
    return user;
  }

  @override
  State<StatefulWidget> createState() {
    return _UserBoxState();
  }
}

class _UserBoxState extends State<UserBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(color: Colors.white70, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(70),
          ),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.user.length != 0 ? Icons.person_pin : Icons.forward,
                  color: Colors.red[400],
                  size: 70,
                ),
                Text(
                  widget.user.length != 0
                      ? widget.user.substring(0, widget.user.indexOf('@'))
                      : 'Ingresar',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
