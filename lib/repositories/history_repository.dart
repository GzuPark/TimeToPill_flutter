import 'dart:developer';

import 'package:hive/hive.dart';

import 'package:time_to_pill/models/pill_history.dart';
import 'package:time_to_pill/repositories/project_hive.dart';

class HistoryRepository {
  Box<PillHistory>? _historyBox;

  /// Directly call the box will be crashed when the application start due to use the global variable in the `main.dart`
  /// It is possible to connect to the box and ensure the safety, and whenever use the getter during the service
  Box<PillHistory> get historyBox {
    _historyBox ??= Hive.box<PillHistory>(ProjectHiveBox.history);
    return _historyBox!;
  }

  void addHistory(PillHistory pill) async {
    int key = await historyBox.add(pill);

    log('[addHistory] add (key: $key) $pill');
    log('result ${historyBox.values.toList()}');
  }

  void deleteHistory(int key) async {
    await historyBox.delete(key);

    log('[deleteHistory] delete (key: $key)');
    log('result ${historyBox.values.toList()}');
  }

  void deleteAllHistories(Iterable<int> keys) async {
    await historyBox.deleteAll(keys);

    log('[deleteAllHistories] delete (keys: $keys)');
    log('result ${historyBox.values.toList()}');
  }

  void updateHistory({
    required int key,
    required PillHistory pill,
  }) async {
    await historyBox.put(key, pill);

    log('[updateHistory] update (key: $key) $pill');
    log('result ${historyBox.values.toList()}');
  }

  /// Get the incremental integer value for creating the unique integer value
  int get newId {
    final lastId = historyBox.values.isEmpty ? 0 : historyBox.values.last.pillId;
    return lastId + 1;
  }
}
