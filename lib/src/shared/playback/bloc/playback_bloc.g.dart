// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlaybackState _$$_PlaybackStateFromJson(Map<String, dynamic> json) =>
    _$_PlaybackState(
      volume: (json['volume'] as num?)?.toDouble() ?? 0.5,
      previousVolume: (json['previousVolume'] as num?)?.toDouble(),
      isMuted: json['isMuted'] as bool? ?? false,
      isPlaying: json['isPlaying'] as bool? ?? false,
      isFullPlayerOn: json['isFullPlayerOn'] as bool? ?? false,
      repeatMode:
          $enumDecodeNullable(_$RepeatModeEnumMap, json['repeatMode']) ??
              RepeatMode.noRepeat,
      queue: SongQueue.fromJson(json['queue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PlaybackStateToJson(_$_PlaybackState instance) =>
    <String, dynamic>{
      'volume': instance.volume,
      'previousVolume': instance.previousVolume,
      'isMuted': instance.isMuted,
      'isPlaying': instance.isPlaying,
      'isFullPlayerOn': instance.isFullPlayerOn,
      'repeatMode': _$RepeatModeEnumMap[instance.repeatMode]!,
      'queue': instance.queue,
    };

const _$RepeatModeEnumMap = {
  RepeatMode.noRepeat: 'noRepeat',
  RepeatMode.repeatCurrent: 'repeatCurrent',
  RepeatMode.repeatQueue: 'repeatQueue',
};

_$_SongWithProgress _$$_SongWithProgressFromJson(Map<String, dynamic> json) =>
    _$_SongWithProgress(
      progress: Duration(microseconds: json['progress'] as int),
      song: Song.fromJson(json['song'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SongWithProgressToJson(_$_SongWithProgress instance) =>
    <String, dynamic>{
      'progress': instance.progress.inMicroseconds,
      'song': instance.song,
    };
