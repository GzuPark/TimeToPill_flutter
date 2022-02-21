import 'package:hive_flutter/hive_flutter.dart';

import 'package:time_to_pill/models/pill.dart';
import 'package:time_to_pill/models/pill_history.dart';

class ProjectHive {
  Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter<Pill>(PillAdapter());
    Hive.registerAdapter<PillHistory>(PillHistoryAdapter());

    await Hive.openBox(ProjectHiveBox.config);
    await Hive.openBox<Pill>(ProjectHiveBox.pill);
    await Hive.openBox<PillHistory>(ProjectHiveBox.history);
  }
}

class ProjectHiveBox {
  static const String config = 'timeToPillConfig';
  static const String pill = 'timeToPill';
  static const String history = 'timeToPillHistory';
}
