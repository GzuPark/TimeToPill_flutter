import 'package:hive/hive.dart';

import 'package:time_to_pill/repositories/project_hive.dart';

class PillConfigRepository {
  Box? _pillConfigBox;

  Box get pillConfigBox {
    _pillConfigBox ??= Hive.box(ProjectHiveBox.config);
    return _pillConfigBox!;
  }

  bool get isDark => pillConfigBox.get('isDark', defaultValue: false);

  /// Switch the theme to the opposite theme
  void get switchTheme => isDark ? pillConfigBox.put('isDark', false) : pillConfigBox.put('isDark', true);
}
