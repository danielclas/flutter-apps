import 'package:carousel_slider/carousel_slider.dart';
import 'package:didactic_table_app/utils/constants.dart';
import 'package:flutter/material.dart';

class UsersSlider extends StatelessWidget {
  final Function handler;

  UsersSlider({this.handler});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: kUserIcons,
      options: CarouselOptions(
        height: 80,
        viewportFraction: 0.4,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        enlargeCenterPage: true,
        onPageChanged: (index, b) => handler(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
