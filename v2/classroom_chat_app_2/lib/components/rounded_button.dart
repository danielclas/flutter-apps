import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;

  RoundedButton({this.text, this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: this.color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: this.onPressed,
        minWidth: 300.0,
        height: 42.0,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
