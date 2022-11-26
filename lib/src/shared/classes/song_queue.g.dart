// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_queue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SongQueue _$$_SongQueueFromJson(Map<String, dynamic> json) => _$_SongQueue(
      songs: (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPlayingTitle: json['currentPlayingTitle'] as String?,
      songWithProgress: json['songWithProgress'] == null
          ? null
          : SongWithProgress.fromJson(
              json['songWithProgress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SongQueueToJson(_$_SongQueue instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'currentPlayingTitle': instance.currentPlayingTitle,
      'songWithProgress': instance.songWithProgress,
    };
