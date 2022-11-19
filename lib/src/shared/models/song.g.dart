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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      const DateTimeConverter().fromJson(json['dateAdded'] as String),
      _$JsonConverterFromJson<String, DateTime>(
          json['dateLastListened'], const DateTimeConverter().fromJson),
      json['listenCount'] as int,
      id: const ObjectIdConverter().fromJson(json['id'] as String),
      title: json['title'] as String,
      path: json['path'] as String,
      album: const ObjectIdConverter().fromJson(json['album'] as String),
      artist: const ObjectIdConverter().fromJson(json['artist'] as String),
      length: const DurationConverter().fromJson(json['length'] as int),
      image: const Uint8ListConverter().fromJson(json['image'] as List<int>),
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'listenCount': instance.listenCount,
      'dateAdded': const DateTimeConverter().toJson(instance.dateAdded),
      'dateLastListened': _$JsonConverterToJson<String, DateTime>(
          instance.dateLastListened, const DateTimeConverter().toJson),
      'id': const ObjectIdConverter().toJson(instance.id),
      'artist': const ObjectIdConverter().toJson(instance.artist),
      'album': const ObjectIdConverter().toJson(instance.album),
      'title': instance.title,
      'path': instance.path,
      'length': const DurationConverter().toJson(instance.length),
      'image': const Uint8ListConverter().toJson(instance.image),
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
