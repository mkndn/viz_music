// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranked.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RankedAdapter extends TypeAdapter<Ranked> {
  @override
  final int typeId = 0;

  @override
  Ranked read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ranked(
      dateAdded: fields[8] as DateTime,
      dateLastListened: fields[9] as DateTime?,
      listenCount: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Ranked obj) {
    writer
      ..writeByte(3)
      ..writeByte(7)
      ..write(obj.listenCount)
      ..writeByte(8)
      ..write(obj.dateAdded)
      ..writeByte(9)
      ..write(obj.dateLastListened);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RankedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
