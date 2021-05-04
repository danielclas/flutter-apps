import 'package:flutter/material.dart';

extension PercentageOfDouble on double {
  //To be used for percentage calculation.
  //i.e. 4.percentOf(100) is 4% of 100
  double percentOf(double value) => (this / 100) * value;
}

extension PercentageOfInt on int {
  //To be used for percentage calculation.
  //i.e. 4.percentOf(100) is 4% of 100
  double percentOf(double value) => (this / 100) * value;
}

extension Query on BuildContext {
  //Made to access width or height of context
  //without having to write entire expression
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
