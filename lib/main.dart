import 'package:flutter/material.dart';

import 'package:time_to_pill/components/project_themes.dart';
import 'package:time_to_pill/pages/home_page.dart';
import 'package:time_to_pill/repositories/pill_repository.dart';
import 'package:time_to_pill/repositories/project_hive.dart';
import 'package:time_to_pill/services/notification_service.dart';

final notification = NotificationService();
final hive = ProjectHive();
final pillRepository = PillRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
