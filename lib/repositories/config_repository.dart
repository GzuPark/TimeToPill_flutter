import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:time_to_pill/components/project_themes.dart';
import 'package:time_to_pill/repositories/project_hive.dart';

class PillConfigRepository {
  Box? _pillConfigBox;

  Box get pillConfigBox {
    _pillConfigBox ??= Hive.box(ProjectHiveBox.config);
    return _pillConfigBox!;
  }

  bool get isDark => pillConfigBox.get('isDark', defaultValue: false);

  ThemeData get getTheme {
    bool isDark = pillConfigBox.get('isDark', defaultValue: false);
    return isDark ? ProjectThemes.darkTheme : ProjectThemes.lightTheme;
  }

  /// Switch the theme to the opposite theme
  void get switchTheme => isDark ? pillConfigBox.put('isDark', false) : pillConfigBox.put('isDark', true);
}
