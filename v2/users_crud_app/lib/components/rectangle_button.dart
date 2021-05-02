import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;
  final double minWidth;
  final Widget child;

  RectangleButton({this.text, this.color, @required this.onPressed, this.minWidth, this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: this.color,
      child: MaterialButton(
        onPressed: this.onPressed,
        minWidth: minWidth,
        height: 42.0,
        child: child != null ? child : Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
