import 'package:flutter/material.dart';

class ProjectColors {
  static const int _primaryLightColorValue = 0xFF151515;
  static const primaryLightColor = Color(_primaryLightColorValue);

  static const MaterialColor primaryLightMaterialColor = MaterialColor(
    _primaryLightColorValue,
    <int, Color>{
      50: Color(_primaryLightColorValue),
      100: Color(_primaryLightColorValue),
      200: Color(_primaryLightColorValue),
      300: Color(_primaryLightColorValue),
      400: Color(_primaryLightColorValue),
      500: Color(_primaryLightColorValue),
      600: Color(_primaryLightColorValue),
      700: Color(_primaryLightColorValue),
      800: Color(_primaryLightColorValue),
      900: Color(_primaryLightColorValue),
    },
  );

  static const int _primaryDarkColorValue = 0xFFCFCFCF;
  static const primaryDarkColor = Color(_primaryDarkColorValue);

  static const MaterialColor primaryDarkMaterialColor = MaterialColor(
    _primaryDarkColorValue,
    <int, Color>{
      50: Color(_primaryDarkColorValue),
      100: Color(_primaryDarkColorValue),
      200: Color(_primaryDarkColorValue),
      300: Color(_primaryDarkColorValue),
      400: Color(_primaryDarkColorValue),
      500: Color(_primaryDarkColorValue),
      600: Color(_primaryDarkColorValue),
      700: Color(_primaryDarkColorValue),
      800: Color(_primaryDarkColorValue),
      900: Color(_primaryDarkColorValue),
    },
  );
}
