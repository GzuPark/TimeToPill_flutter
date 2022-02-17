import 'dart:developer';

import 'package:hive/hive.dart';

import 'package:time_to_pill/models/pill.dart';
import 'package:time_to_pill/repositories/project_hive.dart';

class PillRepository {
  Box<Pill>? _pillBox;

  /// Directly call the box will be crashed when the application start due to use the global variable in the `main.dart`
  /// It is possible to connect to the box and ensure the safety, and whenever use the getter during the service
  Box<Pill> get pillBox {
    _pillBox ??= Hive.box<Pill>(ProjectHiveBox.pill);
    return _pillBox!;
  }

  void addPill(Pill pill) async {
    int key = await pillBox.add(pill);

    log('[addPill] add (key: $key) $pill');
    log('result ${pillBox.values.toList()}');
  }

  void deletePill(int key) async {
    await pillBox.delete(key);

    log('[deletePill] delete (key: $key)');
    log('result ${pillBox.values.toList()}');
  }

  void updatePill({
    required int key,
    required Pill pill,
  }) async {
    await pillBox.put(key, pill);

    log('[updatePill] update (key: $key) $pill');
    log('result ${pillBox.values.toList()}');
  }

  /// Get the incremental integer value for creating the unique integer value
  /// This value will combine with time value (HHmm), then it can convert to string value
  /// Both the integer and string values help to register the unique notification
  int get newId {
    final lastId = pillBox.values.isEmpty ? 0 : pillBox.values.last.id;
    return lastId + 1;
  }
}
