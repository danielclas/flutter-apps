import 'package:didactic_table_app/components/slidable_item.dart';
import 'package:flutter/material.dart';
import '../utils/extension_methods.dart';
import '../utils/constants.dart';

// ignore: must_be_immutable
class ImageTiles extends StatelessWidget {
  int section, language;
  Function onTap;

  ImageTiles({this.section, this.language, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.percentOf(context.height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => this.onTap(this.section, this.language, 0),
                  child: ImageTile(kSectionImages[this.section][0]),
                ),
                GestureDetector(
                  onTap: () => this.onTap(this.section, this.language, 1),
                  child: ImageTile(kSectionImages[this.section][1]),
                ),
                GestureDetector(
                  onTap: () => this.onTap(this.section, this.language, 2),
                  child: ImageTile(kSectionImages[this.section][2]),
                ),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => this.onTap(this.section, this.language, 3),
                  child: ImageTile(kSectionImages[this.section][3]),
                ),
                GestureDetector(
                  onTap: () => this.onTap(this.section, this.language, 4),
                  child: ImageTile(kSectionImages[this.section][4]),
                ),
              ]),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ImageTile extends StatelessWidget {
  String item;
  ImageTile(this.item);

  @override
  Widget build(BuildContext context) {
    return SlidableSquare(
        child: Container(
            height: 18.percentOf(context.height),
            width: 23.percentOf(context.width),
            child: Image(image: AssetImage('images/${this.item}'))));
  }
}
