// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final int typeId = 2;

  @override
  Album read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Album(
      fields[8] as DateTime,
      fields[9] as DateTime?,
      fields[7] as int,
      id: fields[0] as ObjectId,
      title: fields[1] as String,
      image: fields[2] as Uint8List,
      songsInAlbum: (fields[5] as List).cast<ObjectId>(),
      albumArtist: fields[3] as String?,
      year: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.albumArtist)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.songsInAlbum)
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
      other is AlbumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
