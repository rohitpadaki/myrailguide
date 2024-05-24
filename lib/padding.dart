import 'package:flutter/material.dart';

class Paddings {
  static const double horizontal = 25;

  static const EdgeInsets appbar =
      EdgeInsets.only(left: horizontal, right: horizontal, top: 20);

  static const EdgeInsets maincontent =
      EdgeInsets.symmetric(horizontal: horizontal);

  static const EdgeInsets buttonpad =
      EdgeInsets.symmetric(horizontal: horizontal, vertical: 12);

  static const EdgeInsets doublepad =
      EdgeInsets.symmetric(horizontal: horizontal, vertical: horizontal);

  static const EdgeInsets dialogpad =
      EdgeInsets.symmetric(horizontal: 35, vertical: 25);
}
