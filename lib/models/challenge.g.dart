// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChallengeAdapter extends TypeAdapter<Challenge> {
  @override
  final int typeId = 9;

  @override
  Challenge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Challenge(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      goal: fields[3] as Goal,
      duration: fields[4] as int,
      forMuslims: fields[5] as bool,
      participants: fields[8] as int,
      color: fields[9] as String,
      hadith_en: fields[6] as String,
      hadith_ar: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Challenge obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.goal)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.forMuslims)
      ..writeByte(6)
      ..write(obj.hadith_en)
      ..writeByte(7)
      ..write(obj.hadith_ar)
      ..writeByte(8)
      ..write(obj.participants)
      ..writeByte(9)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
