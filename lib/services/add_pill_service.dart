import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:time_to_pill/main.dart';

class AddPillService with ChangeNotifier {
  AddPillService(int updatePillId) {
    final isUpdate = updatePillId != -1;
    if (isUpdate) {
      final updateAlarms = pillRepository.pillBox.values.singleWhere((pill) => pill.id == updatePillId).alarms;
      _alarms.clear();
      _alarms.addAll(updateAlarms);
    }
  }

  final Set<String> _alarms = {
    '08:00',
    '13:00',
    '19:00',
  };

  Set<String> get alarms => _alarms;

  Set<String> get sortedAlarms {
    final alarmList = _alarms.toList();
    alarmList.sort();

    final newAlarms = {...alarmList};
    return newAlarms;
  }

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
