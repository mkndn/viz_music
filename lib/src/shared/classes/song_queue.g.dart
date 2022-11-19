// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SongQueue _$$_SongQueueFromJson(Map<String, dynamic> json) => _$_SongQueue(
      songs: (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPlayingId: _$JsonConverterFromJson<String, ObjectId>(
          json['currentPlayingId'], const ObjectIdConverter().fromJson),
      songWithProgress: json['songWithProgress'] == null
          ? null
          : SongWithProgress.fromJson(
              json['songWithProgress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SongQueueToJson(_$_SongQueue instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'currentPlayingId': _$JsonConverterToJson<String, ObjectId>(
          instance.currentPlayingId, const ObjectIdConverter().toJson),
      'songWithProgress': instance.songWithProgress,
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
