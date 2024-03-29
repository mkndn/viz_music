// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'playback_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PlaybackEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackEventCopyWith<$Res> {
  factory $PlaybackEventCopyWith(
          PlaybackEvent value, $Res Function(PlaybackEvent) then) =
      _$PlaybackEventCopyWithImpl<$Res, PlaybackEvent>;
}

/// @nodoc
class _$PlaybackEventCopyWithImpl<$Res, $Val extends PlaybackEvent>
    implements $PlaybackEventCopyWith<$Res> {
  _$PlaybackEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TogglePlayPauseCopyWith<$Res> {
  factory _$$TogglePlayPauseCopyWith(
          _$TogglePlayPause value, $Res Function(_$TogglePlayPause) then) =
      __$$TogglePlayPauseCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TogglePlayPauseCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$TogglePlayPause>
    implements _$$TogglePlayPauseCopyWith<$Res> {
  __$$TogglePlayPauseCopyWithImpl(
      _$TogglePlayPause _value, $Res Function(_$TogglePlayPause) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TogglePlayPause implements TogglePlayPause {
  const _$TogglePlayPause();

  @override
  String toString() {
    return 'PlaybackEvent.togglePlayPause()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TogglePlayPause);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return togglePlayPause();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return togglePlayPause?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (togglePlayPause != null) {
      return togglePlayPause();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return togglePlayPause(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return togglePlayPause?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (togglePlayPause != null) {
      return togglePlayPause(this);
    }
    return orElse();
  }
}

abstract class TogglePlayPause implements PlaybackEvent {
  const factory TogglePlayPause() = _$TogglePlayPause;
}

/// @nodoc
abstract class _$$InitQueueCopyWith<$Res> {
  factory _$$InitQueueCopyWith(
          _$InitQueue value, $Res Function(_$InitQueue) then) =
      __$$InitQueueCopyWithImpl<$Res>;
  @useResult
  $Res call({SongQueue songQueue});

  $SongQueueCopyWith<$Res> get songQueue;
}

/// @nodoc
class __$$InitQueueCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$InitQueue>
    implements _$$InitQueueCopyWith<$Res> {
  __$$InitQueueCopyWithImpl(
      _$InitQueue _value, $Res Function(_$InitQueue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songQueue = null,
  }) {
    return _then(_$InitQueue(
      null == songQueue
          ? _value.songQueue
          : songQueue // ignore: cast_nullable_to_non_nullable
              as SongQueue,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SongQueueCopyWith<$Res> get songQueue {
    return $SongQueueCopyWith<$Res>(_value.songQueue, (value) {
      return _then(_value.copyWith(songQueue: value));
    });
  }
}

/// @nodoc

class _$InitQueue implements InitQueue {
  const _$InitQueue(this.songQueue);

  @override
  final SongQueue songQueue;

  @override
  String toString() {
    return 'PlaybackEvent.initQueue(songQueue: $songQueue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitQueue &&
            (identical(other.songQueue, songQueue) ||
                other.songQueue == songQueue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, songQueue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitQueueCopyWith<_$InitQueue> get copyWith =>
      __$$InitQueueCopyWithImpl<_$InitQueue>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return initQueue(songQueue);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return initQueue?.call(songQueue);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (initQueue != null) {
      return initQueue(songQueue);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return initQueue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return initQueue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (initQueue != null) {
      return initQueue(this);
    }
    return orElse();
  }
}

abstract class InitQueue implements PlaybackEvent {
  const factory InitQueue(final SongQueue songQueue) = _$InitQueue;

  SongQueue get songQueue;
  @JsonKey(ignore: true)
  _$$InitQueueCopyWith<_$InitQueue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddToQueueCopyWith<$Res> {
  factory _$$AddToQueueCopyWith(
          _$AddToQueue value, $Res Function(_$AddToQueue) then) =
      __$$AddToQueueCopyWithImpl<$Res>;
  @useResult
  $Res call({Song song});
}

/// @nodoc
class __$$AddToQueueCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$AddToQueue>
    implements _$$AddToQueueCopyWith<$Res> {
  __$$AddToQueueCopyWithImpl(
      _$AddToQueue _value, $Res Function(_$AddToQueue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? song = null,
  }) {
    return _then(_$AddToQueue(
      null == song
          ? _value.song
          : song // ignore: cast_nullable_to_non_nullable
              as Song,
    ));
  }
}

/// @nodoc

class _$AddToQueue implements AddToQueue {
  const _$AddToQueue(this.song);

  @override
  final Song song;

  @override
  String toString() {
    return 'PlaybackEvent.addToQueue(song: $song)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddToQueue &&
            (identical(other.song, song) || other.song == song));
  }

  @override
  int get hashCode => Object.hash(runtimeType, song);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddToQueueCopyWith<_$AddToQueue> get copyWith =>
      __$$AddToQueueCopyWithImpl<_$AddToQueue>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return addToQueue(song);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return addToQueue?.call(song);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (addToQueue != null) {
      return addToQueue(song);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return addToQueue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return addToQueue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (addToQueue != null) {
      return addToQueue(this);
    }
    return orElse();
  }
}

abstract class AddToQueue implements PlaybackEvent {
  const factory AddToQueue(final Song song) = _$AddToQueue;

  Song get song;
  @JsonKey(ignore: true)
  _$$AddToQueueCopyWith<_$AddToQueue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NextInQueueCopyWith<$Res> {
  factory _$$NextInQueueCopyWith(
          _$NextInQueue value, $Res Function(_$NextInQueue) then) =
      __$$NextInQueueCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NextInQueueCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$NextInQueue>
    implements _$$NextInQueueCopyWith<$Res> {
  __$$NextInQueueCopyWithImpl(
      _$NextInQueue _value, $Res Function(_$NextInQueue) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NextInQueue implements NextInQueue {
  const _$NextInQueue();

  @override
  String toString() {
    return 'PlaybackEvent.nextInQueue()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NextInQueue);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return nextInQueue();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return nextInQueue?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (nextInQueue != null) {
      return nextInQueue();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return nextInQueue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return nextInQueue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (nextInQueue != null) {
      return nextInQueue(this);
    }
    return orElse();
  }
}

abstract class NextInQueue implements PlaybackEvent {
  const factory NextInQueue() = _$NextInQueue;
}

/// @nodoc
abstract class _$$ChangeSongCopyWith<$Res> {
  factory _$$ChangeSongCopyWith(
          _$ChangeSong value, $Res Function(_$ChangeSong) then) =
      __$$ChangeSongCopyWithImpl<$Res>;
  @useResult
  $Res call({String songId});
}

/// @nodoc
class __$$ChangeSongCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$ChangeSong>
    implements _$$ChangeSongCopyWith<$Res> {
  __$$ChangeSongCopyWithImpl(
      _$ChangeSong _value, $Res Function(_$ChangeSong) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songId = null,
  }) {
    return _then(_$ChangeSong(
      null == songId
          ? _value.songId
          : songId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangeSong implements ChangeSong {
  const _$ChangeSong(this.songId);

  @override
  final String songId;

  @override
  String toString() {
    return 'PlaybackEvent.changeSong(songId: $songId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeSong &&
            (identical(other.songId, songId) || other.songId == songId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, songId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeSongCopyWith<_$ChangeSong> get copyWith =>
      __$$ChangeSongCopyWithImpl<_$ChangeSong>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return changeSong(songId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return changeSong?.call(songId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (changeSong != null) {
      return changeSong(songId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return changeSong(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return changeSong?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (changeSong != null) {
      return changeSong(this);
    }
    return orElse();
  }
}

abstract class ChangeSong implements PlaybackEvent {
  const factory ChangeSong(final String songId) = _$ChangeSong;

  String get songId;
  @JsonKey(ignore: true)
  _$$ChangeSongCopyWith<_$ChangeSong> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetVolumeCopyWith<$Res> {
  factory _$$SetVolumeCopyWith(
          _$SetVolume value, $Res Function(_$SetVolume) then) =
      __$$SetVolumeCopyWithImpl<$Res>;
  @useResult
  $Res call({double value});
}

/// @nodoc
class __$$SetVolumeCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$SetVolume>
    implements _$$SetVolumeCopyWith<$Res> {
  __$$SetVolumeCopyWithImpl(
      _$SetVolume _value, $Res Function(_$SetVolume) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SetVolume(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SetVolume implements SetVolume {
  const _$SetVolume(this.value);

  @override
  final double value;

  @override
  String toString() {
    return 'PlaybackEvent.setVolume(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetVolume &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetVolumeCopyWith<_$SetVolume> get copyWith =>
      __$$SetVolumeCopyWithImpl<_$SetVolume>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return setVolume(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return setVolume?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (setVolume != null) {
      return setVolume(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return setVolume(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return setVolume?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (setVolume != null) {
      return setVolume(this);
    }
    return orElse();
  }
}

abstract class SetVolume implements PlaybackEvent {
  const factory SetVolume(final double value) = _$SetVolume;

  double get value;
  @JsonKey(ignore: true)
  _$$SetVolumeCopyWith<_$SetVolume> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleMuteCopyWith<$Res> {
  factory _$$ToggleMuteCopyWith(
          _$ToggleMute value, $Res Function(_$ToggleMute) then) =
      __$$ToggleMuteCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleMuteCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$ToggleMute>
    implements _$$ToggleMuteCopyWith<$Res> {
  __$$ToggleMuteCopyWithImpl(
      _$ToggleMute _value, $Res Function(_$ToggleMute) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ToggleMute implements ToggleMute {
  const _$ToggleMute();

  @override
  String toString() {
    return 'PlaybackEvent.toggleMute()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleMute);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return toggleMute();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return toggleMute?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return toggleMute(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return toggleMute?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (toggleMute != null) {
      return toggleMute(this);
    }
    return orElse();
  }
}

abstract class ToggleMute implements PlaybackEvent {
  const factory ToggleMute() = _$ToggleMute;
}

/// @nodoc
abstract class _$$ToggleFullPlayerCopyWith<$Res> {
  factory _$$ToggleFullPlayerCopyWith(
          _$ToggleFullPlayer value, $Res Function(_$ToggleFullPlayer) then) =
      __$$ToggleFullPlayerCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleFullPlayerCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$ToggleFullPlayer>
    implements _$$ToggleFullPlayerCopyWith<$Res> {
  __$$ToggleFullPlayerCopyWithImpl(
      _$ToggleFullPlayer _value, $Res Function(_$ToggleFullPlayer) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ToggleFullPlayer implements ToggleFullPlayer {
  const _$ToggleFullPlayer();

  @override
  String toString() {
    return 'PlaybackEvent.toggleFullPlayer()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleFullPlayer);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return toggleFullPlayer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return toggleFullPlayer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (toggleFullPlayer != null) {
      return toggleFullPlayer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return toggleFullPlayer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return toggleFullPlayer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (toggleFullPlayer != null) {
      return toggleFullPlayer(this);
    }
    return orElse();
  }
}

abstract class ToggleFullPlayer implements PlaybackEvent {
  const factory ToggleFullPlayer() = _$ToggleFullPlayer;
}

/// @nodoc
abstract class _$$ChangeRepeatModeCopyWith<$Res> {
  factory _$$ChangeRepeatModeCopyWith(
          _$ChangeRepeatMode value, $Res Function(_$ChangeRepeatMode) then) =
      __$$ChangeRepeatModeCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChangeRepeatModeCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$ChangeRepeatMode>
    implements _$$ChangeRepeatModeCopyWith<$Res> {
  __$$ChangeRepeatModeCopyWithImpl(
      _$ChangeRepeatMode _value, $Res Function(_$ChangeRepeatMode) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChangeRepeatMode implements ChangeRepeatMode {
  const _$ChangeRepeatMode();

  @override
  String toString() {
    return 'PlaybackEvent.changeRepeatMode()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChangeRepeatMode);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return changeRepeatMode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return changeRepeatMode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (changeRepeatMode != null) {
      return changeRepeatMode();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return changeRepeatMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return changeRepeatMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (changeRepeatMode != null) {
      return changeRepeatMode(this);
    }
    return orElse();
  }
}

abstract class ChangeRepeatMode implements PlaybackEvent {
  const factory ChangeRepeatMode() = _$ChangeRepeatMode;
}

/// @nodoc
abstract class _$$MoveToInSongCopyWith<$Res> {
  factory _$$MoveToInSongCopyWith(
          _$MoveToInSong value, $Res Function(_$MoveToInSong) then) =
      __$$MoveToInSongCopyWithImpl<$Res>;
  @useResult
  $Res call({double percent});
}

/// @nodoc
class __$$MoveToInSongCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$MoveToInSong>
    implements _$$MoveToInSongCopyWith<$Res> {
  __$$MoveToInSongCopyWithImpl(
      _$MoveToInSong _value, $Res Function(_$MoveToInSong) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percent = null,
  }) {
    return _then(_$MoveToInSong(
      null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MoveToInSong implements MoveToInSong {
  const _$MoveToInSong(this.percent);

  @override
  final double percent;

  @override
  String toString() {
    return 'PlaybackEvent.moveToInSong(percent: $percent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoveToInSong &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @override
  int get hashCode => Object.hash(runtimeType, percent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoveToInSongCopyWith<_$MoveToInSong> get copyWith =>
      __$$MoveToInSongCopyWithImpl<_$MoveToInSong>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return moveToInSong(percent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return moveToInSong?.call(percent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (moveToInSong != null) {
      return moveToInSong(percent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return moveToInSong(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return moveToInSong?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (moveToInSong != null) {
      return moveToInSong(this);
    }
    return orElse();
  }
}

abstract class MoveToInSong implements PlaybackEvent {
  const factory MoveToInSong(final double percent) = _$MoveToInSong;

  double get percent;
  @JsonKey(ignore: true)
  _$$MoveToInSongCopyWith<_$MoveToInSong> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SongProgressCopyWith<$Res> {
  factory _$$SongProgressCopyWith(
          _$SongProgress value, $Res Function(_$SongProgress) then) =
      __$$SongProgressCopyWithImpl<$Res>;
  @useResult
  $Res call({Duration duration});
}

/// @nodoc
class __$$SongProgressCopyWithImpl<$Res>
    extends _$PlaybackEventCopyWithImpl<$Res, _$SongProgress>
    implements _$$SongProgressCopyWith<$Res> {
  __$$SongProgressCopyWithImpl(
      _$SongProgress _value, $Res Function(_$SongProgress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = null,
  }) {
    return _then(_$SongProgress(
      null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$SongProgress implements SongProgress {
  const _$SongProgress(this.duration);

  @override
  final Duration duration;

  @override
  String toString() {
    return 'PlaybackEvent.songProgress(duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SongProgress &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SongProgressCopyWith<_$SongProgress> get copyWith =>
      __$$SongProgressCopyWithImpl<_$SongProgress>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() togglePlayPause,
    required TResult Function(SongQueue songQueue) initQueue,
    required TResult Function(Song song) addToQueue,
    required TResult Function() nextInQueue,
    required TResult Function(String songId) changeSong,
    required TResult Function(double value) setVolume,
    required TResult Function() toggleMute,
    required TResult Function() toggleFullPlayer,
    required TResult Function() changeRepeatMode,
    required TResult Function(double percent) moveToInSong,
    required TResult Function(Duration duration) songProgress,
  }) {
    return songProgress(duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? togglePlayPause,
    TResult? Function(SongQueue songQueue)? initQueue,
    TResult? Function(Song song)? addToQueue,
    TResult? Function()? nextInQueue,
    TResult? Function(String songId)? changeSong,
    TResult? Function(double value)? setVolume,
    TResult? Function()? toggleMute,
    TResult? Function()? toggleFullPlayer,
    TResult? Function()? changeRepeatMode,
    TResult? Function(double percent)? moveToInSong,
    TResult? Function(Duration duration)? songProgress,
  }) {
    return songProgress?.call(duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? togglePlayPause,
    TResult Function(SongQueue songQueue)? initQueue,
    TResult Function(Song song)? addToQueue,
    TResult Function()? nextInQueue,
    TResult Function(String songId)? changeSong,
    TResult Function(double value)? setVolume,
    TResult Function()? toggleMute,
    TResult Function()? toggleFullPlayer,
    TResult Function()? changeRepeatMode,
    TResult Function(double percent)? moveToInSong,
    TResult Function(Duration duration)? songProgress,
    required TResult orElse(),
  }) {
    if (songProgress != null) {
      return songProgress(duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TogglePlayPause value) togglePlayPause,
    required TResult Function(InitQueue value) initQueue,
    required TResult Function(AddToQueue value) addToQueue,
    required TResult Function(NextInQueue value) nextInQueue,
    required TResult Function(ChangeSong value) changeSong,
    required TResult Function(SetVolume value) setVolume,
    required TResult Function(ToggleMute value) toggleMute,
    required TResult Function(ToggleFullPlayer value) toggleFullPlayer,
    required TResult Function(ChangeRepeatMode value) changeRepeatMode,
    required TResult Function(MoveToInSong value) moveToInSong,
    required TResult Function(SongProgress value) songProgress,
  }) {
    return songProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TogglePlayPause value)? togglePlayPause,
    TResult? Function(InitQueue value)? initQueue,
    TResult? Function(AddToQueue value)? addToQueue,
    TResult? Function(NextInQueue value)? nextInQueue,
    TResult? Function(ChangeSong value)? changeSong,
    TResult? Function(SetVolume value)? setVolume,
    TResult? Function(ToggleMute value)? toggleMute,
    TResult? Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult? Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult? Function(MoveToInSong value)? moveToInSong,
    TResult? Function(SongProgress value)? songProgress,
  }) {
    return songProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TogglePlayPause value)? togglePlayPause,
    TResult Function(InitQueue value)? initQueue,
    TResult Function(AddToQueue value)? addToQueue,
    TResult Function(NextInQueue value)? nextInQueue,
    TResult Function(ChangeSong value)? changeSong,
    TResult Function(SetVolume value)? setVolume,
    TResult Function(ToggleMute value)? toggleMute,
    TResult Function(ToggleFullPlayer value)? toggleFullPlayer,
    TResult Function(ChangeRepeatMode value)? changeRepeatMode,
    TResult Function(MoveToInSong value)? moveToInSong,
    TResult Function(SongProgress value)? songProgress,
    required TResult orElse(),
  }) {
    if (songProgress != null) {
      return songProgress(this);
    }
    return orElse();
  }
}

abstract class SongProgress implements PlaybackEvent {
  const factory SongProgress(final Duration duration) = _$SongProgress;

  Duration get duration;
  @JsonKey(ignore: true)
  _$$SongProgressCopyWith<_$SongProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

PlaybackState _$PlaybackStateFromJson(Map<String, dynamic> json) {
  return _PlaybackState.fromJson(json);
}

/// @nodoc
mixin _$PlaybackState {
  /// Legal values are between 0 and 1.
  double get volume => throw _privateConstructorUsedError;

  /// Used to restore the volume after un-muting.
  double? get previousVolume => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isFullPlayerOn => throw _privateConstructorUsedError;
  RepeatMode get repeatMode => throw _privateConstructorUsedError;
  SongQueue get queue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlaybackStateCopyWith<PlaybackState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaybackStateCopyWith<$Res> {
  factory $PlaybackStateCopyWith(
          PlaybackState value, $Res Function(PlaybackState) then) =
      _$PlaybackStateCopyWithImpl<$Res, PlaybackState>;
  @useResult
  $Res call(
      {double volume,
      double? previousVolume,
      bool isMuted,
      bool isPlaying,
      bool isFullPlayerOn,
      RepeatMode repeatMode,
      SongQueue queue});

  $SongQueueCopyWith<$Res> get queue;
}

/// @nodoc
class _$PlaybackStateCopyWithImpl<$Res, $Val extends PlaybackState>
    implements $PlaybackStateCopyWith<$Res> {
  _$PlaybackStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? volume = null,
    Object? previousVolume = freezed,
    Object? isMuted = null,
    Object? isPlaying = null,
    Object? isFullPlayerOn = null,
    Object? repeatMode = null,
    Object? queue = null,
  }) {
    return _then(_value.copyWith(
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      previousVolume: freezed == previousVolume
          ? _value.previousVolume
          : previousVolume // ignore: cast_nullable_to_non_nullable
              as double?,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isFullPlayerOn: null == isFullPlayerOn
          ? _value.isFullPlayerOn
          : isFullPlayerOn // ignore: cast_nullable_to_non_nullable
              as bool,
      repeatMode: null == repeatMode
          ? _value.repeatMode
          : repeatMode // ignore: cast_nullable_to_non_nullable
              as RepeatMode,
      queue: null == queue
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as SongQueue,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SongQueueCopyWith<$Res> get queue {
    return $SongQueueCopyWith<$Res>(_value.queue, (value) {
      return _then(_value.copyWith(queue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PlaybackStateCopyWith<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  factory _$$_PlaybackStateCopyWith(
          _$_PlaybackState value, $Res Function(_$_PlaybackState) then) =
      __$$_PlaybackStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double volume,
      double? previousVolume,
      bool isMuted,
      bool isPlaying,
      bool isFullPlayerOn,
      RepeatMode repeatMode,
      SongQueue queue});

  @override
  $SongQueueCopyWith<$Res> get queue;
}

/// @nodoc
class __$$_PlaybackStateCopyWithImpl<$Res>
    extends _$PlaybackStateCopyWithImpl<$Res, _$_PlaybackState>
    implements _$$_PlaybackStateCopyWith<$Res> {
  __$$_PlaybackStateCopyWithImpl(
      _$_PlaybackState _value, $Res Function(_$_PlaybackState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? volume = null,
    Object? previousVolume = freezed,
    Object? isMuted = null,
    Object? isPlaying = null,
    Object? isFullPlayerOn = null,
    Object? repeatMode = null,
    Object? queue = null,
  }) {
    return _then(_$_PlaybackState(
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      previousVolume: freezed == previousVolume
          ? _value.previousVolume
          : previousVolume // ignore: cast_nullable_to_non_nullable
              as double?,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      isFullPlayerOn: null == isFullPlayerOn
          ? _value.isFullPlayerOn
          : isFullPlayerOn // ignore: cast_nullable_to_non_nullable
              as bool,
      repeatMode: null == repeatMode
          ? _value.repeatMode
          : repeatMode // ignore: cast_nullable_to_non_nullable
              as RepeatMode,
      queue: null == queue
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as SongQueue,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlaybackState implements _PlaybackState {
  const _$_PlaybackState(
      {this.volume = 0.5,
      this.previousVolume,
      this.isMuted = false,
      this.isPlaying = false,
      this.isFullPlayerOn = false,
      this.repeatMode = RepeatMode.noRepeat,
      required this.queue});

  factory _$_PlaybackState.fromJson(Map<String, dynamic> json) =>
      _$$_PlaybackStateFromJson(json);

  /// Legal values are between 0 and 1.
  @override
  @JsonKey()
  final double volume;

  /// Used to restore the volume after un-muting.
  @override
  final double? previousVolume;
  @override
  @JsonKey()
  final bool isMuted;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final bool isFullPlayerOn;
  @override
  @JsonKey()
  final RepeatMode repeatMode;
  @override
  final SongQueue queue;

  @override
  String toString() {
    return 'PlaybackState(volume: $volume, previousVolume: $previousVolume, isMuted: $isMuted, isPlaying: $isPlaying, isFullPlayerOn: $isFullPlayerOn, repeatMode: $repeatMode, queue: $queue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlaybackState &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.previousVolume, previousVolume) ||
                other.previousVolume == previousVolume) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.isFullPlayerOn, isFullPlayerOn) ||
                other.isFullPlayerOn == isFullPlayerOn) &&
            (identical(other.repeatMode, repeatMode) ||
                other.repeatMode == repeatMode) &&
            (identical(other.queue, queue) || other.queue == queue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, volume, previousVolume, isMuted,
      isPlaying, isFullPlayerOn, repeatMode, queue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlaybackStateCopyWith<_$_PlaybackState> get copyWith =>
      __$$_PlaybackStateCopyWithImpl<_$_PlaybackState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlaybackStateToJson(
      this,
    );
  }
}

abstract class _PlaybackState implements PlaybackState {
  const factory _PlaybackState(
      {final double volume,
      final double? previousVolume,
      final bool isMuted,
      final bool isPlaying,
      final bool isFullPlayerOn,
      final RepeatMode repeatMode,
      required final SongQueue queue}) = _$_PlaybackState;

  factory _PlaybackState.fromJson(Map<String, dynamic> json) =
      _$_PlaybackState.fromJson;

  @override

  /// Legal values are between 0 and 1.
  double get volume;
  @override

  /// Used to restore the volume after un-muting.
  double? get previousVolume;
  @override
  bool get isMuted;
  @override
  bool get isPlaying;
  @override
  bool get isFullPlayerOn;
  @override
  RepeatMode get repeatMode;
  @override
  SongQueue get queue;
  @override
  @JsonKey(ignore: true)
  _$$_PlaybackStateCopyWith<_$_PlaybackState> get copyWith =>
      throw _privateConstructorUsedError;
}

SongWithProgress _$SongWithProgressFromJson(Map<String, dynamic> json) {
  return _SongWithProgress.fromJson(json);
}

/// @nodoc
mixin _$SongWithProgress {
  Duration get progress => throw _privateConstructorUsedError;
  Song get song => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongWithProgressCopyWith<SongWithProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongWithProgressCopyWith<$Res> {
  factory $SongWithProgressCopyWith(
          SongWithProgress value, $Res Function(SongWithProgress) then) =
      _$SongWithProgressCopyWithImpl<$Res, SongWithProgress>;
  @useResult
  $Res call({Duration progress, Song song});
}

/// @nodoc
class _$SongWithProgressCopyWithImpl<$Res, $Val extends SongWithProgress>
    implements $SongWithProgressCopyWith<$Res> {
  _$SongWithProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? song = null,
  }) {
    return _then(_value.copyWith(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as Duration,
      song: null == song
          ? _value.song
          : song // ignore: cast_nullable_to_non_nullable
              as Song,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SongWithProgressCopyWith<$Res>
    implements $SongWithProgressCopyWith<$Res> {
  factory _$$_SongWithProgressCopyWith(
          _$_SongWithProgress value, $Res Function(_$_SongWithProgress) then) =
      __$$_SongWithProgressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration progress, Song song});
}

/// @nodoc
class __$$_SongWithProgressCopyWithImpl<$Res>
    extends _$SongWithProgressCopyWithImpl<$Res, _$_SongWithProgress>
    implements _$$_SongWithProgressCopyWith<$Res> {
  __$$_SongWithProgressCopyWithImpl(
      _$_SongWithProgress _value, $Res Function(_$_SongWithProgress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? song = null,
  }) {
    return _then(_$_SongWithProgress(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as Duration,
      song: null == song
          ? _value.song
          : song // ignore: cast_nullable_to_non_nullable
              as Song,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SongWithProgress implements _SongWithProgress {
  const _$_SongWithProgress({required this.progress, required this.song});

  factory _$_SongWithProgress.fromJson(Map<String, dynamic> json) =>
      _$$_SongWithProgressFromJson(json);

  @override
  final Duration progress;
  @override
  final Song song;

  @override
  String toString() {
    return 'SongWithProgress(progress: $progress, song: $song)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SongWithProgressCopyWith<_$_SongWithProgress> get copyWith =>
      __$$_SongWithProgressCopyWithImpl<_$_SongWithProgress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SongWithProgressToJson(
      this,
    );
  }
}

abstract class _SongWithProgress implements SongWithProgress {
  const factory _SongWithProgress(
      {required final Duration progress,
      required final Song song}) = _$_SongWithProgress;

  factory _SongWithProgress.fromJson(Map<String, dynamic> json) =
      _$_SongWithProgress.fromJson;

  @override
  Duration get progress;
  @override
  Song get song;
  @override
  @JsonKey(ignore: true)
  _$$_SongWithProgressCopyWith<_$_SongWithProgress> get copyWith =>
      throw _privateConstructorUsedError;
}
