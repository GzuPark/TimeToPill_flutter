import 'package:flutter/material.dart';

import 'package:time_to_pill/components/project_colors.dart';

class ProjectThemes {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: ProjectColors.primaryLightMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.white,
        brightness: Brightness.light,
        fontFamily: 'Gaegu',
        textTheme: _lightTextTheme,
        appBarTheme: _lightAppBarTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static ThemeData get darkTheme => ThemeData(
        primarySwatch: ProjectColors.primaryDarkMaterialColor,
        brightness: Brightness.dark,
        splashColor: Colors.white,
        fontFamily: 'Gaegu',
        textTheme: _darkTextTheme,
        appBarTheme: _darkAppBarTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: ProjectColors.primaryLightColor),
    elevation: 0.0,
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    backgroundColor: Color(0xFF303030),
    elevation: 0.0,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
    subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    subtitle2: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyText1: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    button: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
  );

  static const TextTheme _darkTextTheme = TextTheme(
    headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
    subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    subtitle2: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyText1: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
    button: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
  );
}
