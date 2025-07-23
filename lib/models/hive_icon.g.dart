// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_icon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveIconAdapter extends TypeAdapter<HiveIcon> {
  @override
  final int typeId = 5;

  @override
  HiveIcon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveIcon(
      code: fields[0] as int,
      family: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveIcon obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.family);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveIconAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
