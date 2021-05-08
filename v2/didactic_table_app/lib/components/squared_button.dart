import 'package:didactic_table_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import '../utils/extension_methods.dart';

class SquaredButton extends StatelessWidget {
  final Function handler;
  final Widget child;
  SquaredButton({this.handler, this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: handler == null ? Colors.grey : Colors.white,
        child: GestureDetector(
          onTap: handler,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  border: Border.all(width: 2.percentOf(context.width), color: HexColor("ededd0"))),
              height: 15.percentOf(context.height),
              width: 30.percentOf(context.width),
              child: Center(child: child)),
        ));
  }
}
