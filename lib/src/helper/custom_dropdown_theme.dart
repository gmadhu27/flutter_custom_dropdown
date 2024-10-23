import 'package:flutter/material.dart';

class CustomDropdownTheme {
  final Color? backgroundColor;
  final Color? backIconColor;
  final TextStyle? titleTextStyle;
  final InputDecoration? searchBoxDecoration;
  final BoxDecoration? bottomSheetBoxDecoration;

  CustomDropdownTheme(
      {this.backgroundColor,
      this.backIconColor,
      this.titleTextStyle,
      this.searchBoxDecoration,
      this.bottomSheetBoxDecoration});
}
