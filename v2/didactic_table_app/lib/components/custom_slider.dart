import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../utils/extension_methods.dart';

class CustomSlider extends StatelessWidget {
  final List<Widget> children;
  final Function handler;
  final double height;

  CustomSlider({this.children, this.handler, this.height});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: children,
      options: CarouselOptions(
        height: height ?? 80,
        viewportFraction: 0.4,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        enlargeCenterPage: true,
        onPageChanged: handler,
        scrollDirection: context.height > context.width ? Axis.horizontal : Axis.vertical,
      ),
    );
  }
}
