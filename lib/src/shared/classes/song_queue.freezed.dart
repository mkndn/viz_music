// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'song_queue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SongQueue _$SongQueueFromJson(Map<String, dynamic> json) {
  return _SongQueue.fromJson(json);
}

/// @nodoc
mixin _$SongQueue {
  List<Song> get songs => throw _privateConstructorUsedError;
  @ObjectIdConverter()
  ObjectId? get currentPlayingId => throw _privateConstructorUsedError;
  SongWithProgress? get songWithProgress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongQueueCopyWith<SongQueue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongQueueCopyWith<$Res> {
  factory $SongQueueCopyWith(SongQueue value, $Res Function(SongQueue) then) =
      _$SongQueueCopyWithImpl<$Res, SongQueue>;
  @useResult
  $Res call(
      {List<Song> songs,
      @ObjectIdConverter() ObjectId? currentPlayingId,
      SongWithProgress? songWithProgress});

  $SongWithProgressCopyWith<$Res>? get songWithProgress;
}

/// @nodoc
class _$SongQueueCopyWithImpl<$Res, $Val extends SongQueue>
    implements $SongQueueCopyWith<$Res> {
  _$SongQueueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? currentPlayingId = freezed,
    Object? songWithProgress = freezed,
  }) {
    return _then(_value.copyWith(
      songs: null == songs
          ? _value.songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      currentPlayingId: freezed == currentPlayingId
          ? _value.currentPlayingId
          : currentPlayingId // ignore: cast_nullable_to_non_nullable
              as ObjectId?,
      songWithProgress: freezed == songWithProgress
          ? _value.songWithProgress
          : songWithProgress // ignore: cast_nullable_to_non_nullable
              as SongWithProgress?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SongWithProgressCopyWith<$Res>? get songWithProgress {
    if (_value.songWithProgress == null) {
      return null;
    }

    return $SongWithProgressCopyWith<$Res>(_value.songWithProgress!, (value) {
      return _then(_value.copyWith(songWithProgress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SongQueueCopyWith<$Res> implements $SongQueueCopyWith<$Res> {
  factory _$$_SongQueueCopyWith(
          _$_SongQueue value, $Res Function(_$_SongQueue) then) =
      __$$_SongQueueCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Song> songs,
      @ObjectIdConverter() ObjectId? currentPlayingId,
      SongWithProgress? songWithProgress});

  @override
  $SongWithProgressCopyWith<$Res>? get songWithProgress;
}

/// @nodoc
class __$$_SongQueueCopyWithImpl<$Res>
    extends _$SongQueueCopyWithImpl<$Res, _$_SongQueue>
    implements _$$_SongQueueCopyWith<$Res> {
  __$$_SongQueueCopyWithImpl(
      _$_SongQueue _value, $Res Function(_$_SongQueue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? songs = null,
    Object? currentPlayingId = freezed,
    Object? songWithProgress = freezed,
  }) {
    return _then(_$_SongQueue(
      songs: null == songs
          ? _value._songs
          : songs // ignore: cast_nullable_to_non_nullable
              as List<Song>,
      currentPlayingId: freezed == currentPlayingId
          ? _value.currentPlayingId
          : currentPlayingId // ignore: cast_nullable_to_non_nullable
              as ObjectId?,
      songWithProgress: freezed == songWithProgress
          ? _value.songWithProgress
          : songWithProgress // ignore: cast_nullable_to_non_nullable
              as SongWithProgress?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SongQueue extends _SongQueue {
  const _$_SongQueue(
      {required final List<Song> songs,
      @ObjectIdConverter() this.currentPlayingId,
      this.songWithProgress})
      : _songs = songs,
        super._();

  factory _$_SongQueue.fromJson(Map<String, dynamic> json) =>
      _$$_SongQueueFromJson(json);

  final List<Song> _songs;
  @override
  List<Song> get songs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  @ObjectIdConverter()
  final ObjectId? currentPlayingId;
  @override
  final SongWithProgress? songWithProgress;

  @override
  String toString() {
    return 'SongQueue(songs: $songs, currentPlayingId: $currentPlayingId, songWithProgress: $songWithProgress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SongQueue &&
            const DeepCollectionEquality().equals(other._songs, _songs) &&
            (identical(other.currentPlayingId, currentPlayingId) ||
                other.currentPlayingId == currentPlayingId) &&
            (identical(other.songWithProgress, songWithProgress) ||
                other.songWithProgress == songWithProgress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_songs),
      currentPlayingId,
      songWithProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SongQueueCopyWith<_$_SongQueue> get copyWith =>
      __$$_SongQueueCopyWithImpl<_$_SongQueue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SongQueueToJson(
      this,
    );
  }
}

abstract class _SongQueue extends SongQueue {
  const factory _SongQueue(
      {required final List<Song> songs,
      @ObjectIdConverter() final ObjectId? currentPlayingId,
      final SongWithProgress? songWithProgress}) = _$_SongQueue;
  const _SongQueue._() : super._();

  factory _SongQueue.fromJson(Map<String, dynamic> json) =
      _$_SongQueue.fromJson;

  @override
  List<Song> get songs;
  @override
  @ObjectIdConverter()
  ObjectId? get currentPlayingId;
  @override
  SongWithProgress? get songWithProgress;
  @override
  @JsonKey(ignore: true)
  _$$_SongQueueCopyWith<_$_SongQueue> get copyWith =>
      throw _privateConstructorUsedError;
}
