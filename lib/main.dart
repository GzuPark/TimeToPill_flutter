import 'package:flutter/material.dart';
import 'package:time_to_pill/components/project_themes.dart';
import 'package:time_to_pill/pages/home_page.dart';

void main() {
  runApp(const TimeToPillApp());
}

class TimeToPillApp extends StatelessWidget {
  const TimeToPillApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ProjectThemes.lightTheme,
      // theme: ProjectThemes.darkTheme,
      /// Fixed text scale, not depends on each device setting
      builder: (context, child) => MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
      home: const HomePage(),
    );
  }
}
