import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AddPillService with ChangeNotifier {
  final Set<String> _alarms = {
    '08:00',
    '13:00',
    '19:00',
  };

  Set<String> get alarms => _alarms;

  void addNowAlarm() {
    final now = DateTime.now();
    final nowTime = DateFormat('HH:mm').format(now);

    _alarms.add(nowTime);
    notifyListeners();
  }

  void removeAlarm(String alarmTime) {
    _alarms.remove(alarmTime);
    notifyListeners();
  }

  /// 1. Remove previous time which stored in the alarm list
  /// 2. Add new time which is selected from the TimePicker
  void setAlarm({
    required String prevTime,
    required DateTime setTime,
  }) {
    _alarms.remove(prevTime);

    final setTimeStr = DateFormat('HH:mm').format(setTime);
    _alarms.add(setTimeStr);

    notifyListeners();
  }
}
