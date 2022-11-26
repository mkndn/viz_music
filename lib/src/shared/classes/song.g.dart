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
      title: fields[2] as String,
      path: fields[5] as String,
      album: fields[1] as String,
      year: fields[4] as int,
      artist: fields[0] as String,
      composedBy: fields[3] as String,
      length: fields[6] as Duration,
      albumCover: fields[7] as Uint8List,
      listenCount: fields[8] as int,
      dateAdded: fields[9] as DateTime,
      dateLastListened: fields[10] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.artist)
      ..writeByte(1)
      ..write(obj.album)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.composedBy)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.path)
      ..writeByte(6)
      ..write(obj.length)
      ..writeByte(7)
      ..write(obj.albumCover)
      ..writeByte(8)
      ..write(obj.listenCount)
      ..writeByte(9)
      ..write(obj.dateAdded)
      ..writeByte(10)
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      title: json['title'] as String,
      path: json['path'] as String,
      album: json['album'] as String,
      year: json['year'] as int,
      artist: json['artist'] as String,
      composedBy: json['composedBy'] as String,
      length: const DurationConverter().fromJson(json['length'] as int),
      albumCover:
          const Uint8ListConverter().fromJson(json['albumCover'] as String),
      listenCount: json['listenCount'] as int,
      dateAdded:
          const DateTimeConverter().fromJson(json['dateAdded'] as String),
      dateLastListened: _$JsonConverterFromJson<String, DateTime>(
          json['dateLastListened'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'artist': instance.artist,
      'album': instance.album,
      'title': instance.title,
      'composedBy': instance.composedBy,
      'year': instance.year,
      'path': instance.path,
      'length': const DurationConverter().toJson(instance.length),
      'albumCover': const Uint8ListConverter().toJson(instance.albumCover),
      'listenCount': instance.listenCount,
      'dateAdded': const DateTimeConverter().toJson(instance.dateAdded),
      'dateLastListened': _$JsonConverterToJson<String, DateTime>(
          instance.dateLastListened, const DateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
