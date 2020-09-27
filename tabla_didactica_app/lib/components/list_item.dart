import 'package:flutter/material.dart';
import '.././constants.dart';
import '../services/tts_service.dart';

class ListItem extends StatefulWidget {
  Widget image;
  Text label;
  MaterialColor color;

  ListItem({Key key, this.image, this.label, this.color}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListItemState();
  }
}

class _ListItemState extends State<ListItem> {
  @override
  void dispose() {
    super.dispose();
    Tts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        setState(() {
          Tts.speak(widget.label.data);
        });
      },
      child: SizedBox.expand(
          child: DecoratedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(80, 10, 10, 10),
                child: widget.image),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 80, 10),
                child: widget.label),
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [widget.color[800], widget.color[500]],
                stops: [0.3, 0.8])),
      )),
    ));
  }
}
