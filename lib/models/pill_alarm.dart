class PillAlarm {
  PillAlarm({
    required this.key,
    required this.id,
    required this.name,
    required this.imagePath,
    required this.alarmTime,
  });

  final int key;
  final int id;
  final String name;
  final String? imagePath;
  final String alarmTime;
}
