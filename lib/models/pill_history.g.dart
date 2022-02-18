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
      pillKey: fields[1] == null ? -1 : fields[1] as int,
      alarmTime: fields[2] as String,
      takenTime: fields[3] as DateTime,
      name: fields[4] == null ? '삭제된 약' : fields[4] as String,
      imagePath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PillHistory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.pillId)
      ..writeByte(1)
      ..write(obj.pillKey)
      ..writeByte(2)
      ..write(obj.alarmTime)
      ..writeByte(3)
      ..write(obj.takenTime)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PillHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
