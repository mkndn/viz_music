// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistAdapter extends TypeAdapter<Playlist> {
  @override
  final int typeId = 4;

  @override
  Playlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlist(
      fields[8] as DateTime,
      fields[9] as DateTime?,
      fields[7] as int,
      id: fields[0] as ObjectId,
      title: fields[1] as String,
      cover: fields[3] as Uint8List,
      songs: (fields[4] as List).cast<ObjectId>(),
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Playlist obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.cover)
      ..writeByte(4)
      ..write(obj.songs)
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
      other is PlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
