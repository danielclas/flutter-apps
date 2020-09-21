import 'package:flutter/material.dart';
import '.././constants.dart';

class ListItem extends StatelessWidget {
  Image image;
  Text label;
  MaterialColor color;

  ListItem({this.image, this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox.expand(
            child: DecoratedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(70, 10, 10, 10), child: image),
          Padding(padding: EdgeInsets.fromLTRB(10, 10, 70, 10), child: label),
        ],
      ),
      decoration: BoxDecoration(color: color),
    )));
  }
}
