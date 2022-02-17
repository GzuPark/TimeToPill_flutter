// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PillAdapter extends TypeAdapter<Pill> {
  @override
  final int typeId = 1;

  @override
  Pill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pill(
      id: fields[0] as int,
      name: fields[1] as String,
      imagePath: fields[2] as String?,
      alarms: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Pill obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.alarms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
