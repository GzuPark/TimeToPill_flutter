import 'package:hive/hive.dart';

part 'pill.g.dart';

/// Must run below script for generating the PillAdapter class
///   `flutter packages pub run build_runner build`
/// HiveObject helps to get the key value (integer)
@HiveType(typeId: 1)
class Pill extends HiveObject {
  Pill({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.alarms,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? imagePath;

  @HiveField(3)
  final List<String> alarms;

  @override
  String toString() {
    return '{id: $id, name: $name, imagePath:$imagePath, alarms: $alarms}';
  }
}
