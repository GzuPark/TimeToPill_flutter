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
}
