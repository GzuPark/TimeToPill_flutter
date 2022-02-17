import 'package:hive/hive.dart';

part 'pill_history.g.dart';

/// Must run below script for generating the PillAdapter class
///   `flutter packages pub run build_runner build`
/// HiveObject helps to get the key value (integer)
@HiveType(typeId: 2)
class PillHistory extends HiveObject {
  PillHistory({
    required this.pillId,
    required this.alarmTime,
    required this.takenTime,
  });

  @HiveField(0)
  final int pillId;

  @HiveField(1)
  final String alarmTime;

  @HiveField(2)
  final DateTime takenTime;

  @override
  String toString() {
    return '{pillId: $pillId, alarmTime: $alarmTime, takeTime:$takenTime}';
  }
}
