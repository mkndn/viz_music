// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 1;

  @override
  Song read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Song(
      fields[8] as DateTime,
      fields[9] as DateTime?,
      fields[7] as int,
      id: fields[0] as ObjectId,
      title: fields[3] as String,
      path: fields[4] as String,
      album: fields[2] as ObjectId,
      artist: fields[1] as ObjectId,
      length: fields[5] as Duration,
      image: fields[6] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.album)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.path)
      ..writeByte(5)
      ..write(obj.length)
      ..writeByte(6)
      ..write(obj.image)
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
      other is SongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
