// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekdays.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeekdaysAdapter extends TypeAdapter<Weekdays> {
  @override
  final int typeId = 7;

  @override
  Weekdays read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weekdays(
      isXdaysPerWeek: fields[0] as bool,
      daysPerWeek: fields[1] as int,
      selectedWeekDays: (fields[2] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Weekdays obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isXdaysPerWeek)
      ..writeByte(1)
      ..write(obj.daysPerWeek)
      ..writeByte(2)
      ..write(obj.selectedWeekDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekdaysAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
