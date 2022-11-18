// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtistAdapter extends TypeAdapter<Artist> {
  @override
  final int typeId = 3;

  @override
  Artist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artist(
      fields[8] as DateTime,
      fields[9] as DateTime?,
      fields[7] as int,
      id: fields[0] as ObjectId,
      name: fields[1] as String,
      albums: (fields[2] as List).cast<ObjectId>(),
    );
  }

  @override
  void write(BinaryWriter writer, Artist obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.albums)
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
      other is ArtistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
