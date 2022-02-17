import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notification = FlutterLocalNotificationsPlugin();

class NotificationService {
  Future<void> initializeTimezone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> initializeNotification() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notification.initialize(initializationSettings);
  }

  /// Future<bool>
  /// if true, add notification title, body, and its time
  /// if false, call the snack bar for setting the alert permission
  /// (example)
  ///   alarmTimeStr: HH:mm
  ///   title: HH:mm 약 먹을 시간이에요!
  ///   body: pillName 복약했다고 알려주세요!
  Future<bool> addNotification({
    required int pillId,
    required String alarmTimeStr,
    required String title,
    required String body,
  }) async {
    /// Show native device setting page
    if (!await permissionNotification) return false;

    /// Exception
    final now = tz.TZDateTime.now(tz.local);
    final alarmTime = DateFormat('HH:mm').parse(alarmTimeStr);

    /// Past time cannot add to notification group
    /// Therefore, compare the alarm time and now (especially, minute) before should add 1 more day if time have past
    final day = (alarmTime.hour < now.hour || (alarmTime.hour == now.hour && alarmTime.minute <= now.minute))
        ? now.day + 1
        : now.day;

    /// Unique ID
    String alarmTimeId = alarmTimeStr.replaceAll(':', '');
    alarmTimeId = pillId.toString() + alarmTimeId;

    /// Add scheduled notification
    final details = _notificationDetails(
      alarmTimeId, // unique, str
      title: title,
      body: body,
    );

    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      day,
      alarmTime.hour,
      alarmTime.minute,
    );

    await notification.zonedSchedule(
      int.parse(alarmTimeId), // unique, int
      title,
      body,
      scheduledDate,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    return true;
  }

  /// Android always is true
  /// iOS need to change permissions for changing from true to false: alert, badge, and sound
  /// If cannot get the permission, the application call and move the device setting page own
  Future<bool> get permissionNotification async {
    if (Platform.isAndroid) {
      return true;
    } else if (Platform.isIOS) {
      return await notification
              .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    } else {
      return false;
    }
  }

  /// Notification details
  NotificationDetails _notificationDetails(
    String id, {
    required String title,
    required String body,
  }) {
    const ios = IOSNotificationDetails();
    final android = AndroidNotificationDetails(
      id,
      title,
      channelDescription: body,
      importance: Importance.max,
      priority: Priority.max,
    );

    return NotificationDetails(
      android: android,
      iOS: ios,
    );
  }
}
