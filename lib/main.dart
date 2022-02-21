import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:time_to_pill/components/project_themes.dart';
import 'package:time_to_pill/pages/home_page.dart';
import 'package:time_to_pill/repositories/config_repository.dart';
import 'package:time_to_pill/repositories/history_repository.dart';
import 'package:time_to_pill/repositories/pill_repository.dart';
import 'package:time_to_pill/repositories/project_hive.dart';
import 'package:time_to_pill/services/notification_service.dart';

final notification = NotificationService();
final hive = ProjectHive();
final configRepository = PillConfigRepository();
final pillRepository = PillRepository();
final historyRepository = HistoryRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the Local DateFormat
  await initializeDateFormatting();

  /// Initialize the Notification service
  await notification.initializeTimezone();
  await notification.initializeNotification();

  /// Initialize the Hive instance
  await hive.initializeHive();

  runApp(const TimeToPillApp());
}

class TimeToPillApp extends StatelessWidget {
  const TimeToPillApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: configRepository.pillConfigBox.listenable(),
        builder: (BuildContext context, __, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ProjectThemes.lightTheme,
            darkTheme: ProjectThemes.darkTheme,
            themeMode: configRepository.isDark ? ThemeMode.dark : ThemeMode.light,

            /// Fixed text scale, not depends on each device setting
            builder: (context, child) => MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            ),
            home: const HomePage(),
          );
        });
  }
}
