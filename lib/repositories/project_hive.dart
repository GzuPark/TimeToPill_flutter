import 'package:hive_flutter/hive_flutter.dart';

import 'package:time_to_pill/models/pill.dart';

class ProjectHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Pill>(PillAdapter());
    await Hive.openBox<Pill>(ProjectHiveBox.pill);
  }
}

class ProjectHiveBox {
  static const String pill = 'timeToPill';
}
