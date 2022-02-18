import 'package:hive/hive.dart';

part 'pill_history.g.dart';

/// Must run below script for generating the PillHistoryAdapter class
///   `flutter packages pub run build_runner build`
/// HiveObject helps to get the key value (integer)
@HiveType(typeId: 2)
class PillHistory extends HiveObject {
  PillHistory({
    required this.pillId,
    required this.pillKey,
    required this.alarmTime,
    required this.takenTime,
    required this.name,
    required this.imagePath,
  });

  @HiveField(0)
  final int pillId;

  @HiveField(1, defaultValue: -1)
  final int pillKey;

  @HiveField(2)
  final String alarmTime;

  @HiveField(3)
  final DateTime takenTime;

  @HiveField(4, defaultValue: '삭제된 약')
  final String name;

  @HiveField(5)
  final String? imagePath;

  @override
  String toString() {
    return '{pillId: $pillId, pillKey: $pillKey, alarmTime: $alarmTime, takeTime:$takenTime, name: $name, imagePath: $imagePath}';
  }
}
