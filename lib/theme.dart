import 'package:flutter/material.dart';
import 'package:wensa/main.dart';

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: background2,
    primary: Colors.grey.shade600,
    secondary: blackground,
      tertiary: shadegrey
  ),
);

ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      background: blackground,
      primary: Colors.grey.shade500,
      secondary: background2,
      tertiary: shadegrey2
  ),
);
