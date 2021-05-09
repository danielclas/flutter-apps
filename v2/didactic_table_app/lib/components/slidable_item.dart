import 'package:didactic_table_app/utils/hex_color.dart';
import 'package:flutter/material.dart';
import '../utils/extension_methods.dart';

class SlidableSquare extends StatelessWidget {
  Widget child;

  SlidableSquare({this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 4,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
              decoration: BoxDecoration(
                  color: HexColor('95e1d3'),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      HexColor('eaffd0'),
                      HexColor('95e1d3'),
                    ],
                  )),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: child,
              )))),
    );
  }
}
