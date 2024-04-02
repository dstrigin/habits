// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StampAdapter extends TypeAdapter<Stamp> {
  @override
  final int typeId = 2;

  @override
  Stamp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stamp(
      habit: fields[0] as Habit,
      time: fields[1] as DateTime,
      added: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Stamp obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.habit)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.added);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StampAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
