import 'package:flutter/material.dart';

extension GetTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension GetScreenSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}


