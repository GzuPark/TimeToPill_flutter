// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PillHistoryAdapter extends TypeAdapter<PillHistory> {
  @override
  final int typeId = 2;

  @override
  PillHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PillHistory(
      pillId: fields[0] as int,
      alarmTime: fields[1] as String,
      takenTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, PillHistory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.pillId)
      ..writeByte(1)
      ..write(obj.alarmTime)
      ..writeByte(2)
      ..write(obj.takenTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PillHistoryAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
