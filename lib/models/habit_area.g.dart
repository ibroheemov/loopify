// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_area.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAreaAdapter extends TypeAdapter<HabitArea> {
  @override
  final int typeId = 1;

  @override
  HabitArea read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitArea(
      id: fields[0] as String,
      name: fields[1] as String,
      emoji: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HabitArea obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.emoji);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAreaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
