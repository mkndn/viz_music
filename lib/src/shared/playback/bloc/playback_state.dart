part of 'playback_bloc.dart';

@freezed
class PlaybackState with _$PlaybackState {
  const factory PlaybackState({
    /// Legal values are between 0 and 1.
    @Default(0.5) double volume,

    /// Used to restore the volume after un-muting.
    double? previousVolume,
    @Default(false) bool isMuted,
    @Default(false) bool isPlaying,
    @Default(false) bool isFullPlayerOn,
    SongWithProgress? songWithProgress,
    @Default(RepeatMode.noRepeat) RepeatMode repeatMode,
    required SongQueue queue,
  }) = _PlaybackState;

  factory PlaybackState.initial() => PlaybackState(queue: SongQueue.instance());
  factory PlaybackState.load(PlayerStateModel initialData) {
    return PlaybackState.initial().copyWith(
      songWithProgress: initialData.queue.isNotEmpty
          ? SongWithProgress(
              progress: initialData.progress,
              song: initialData.queue.currentSong,
            )
          : null,
      queue: initialData.queue,
      volume: initialData.volume,
      previousVolume: initialData.previousVolume,
      isMuted: initialData.isMuted,
      isPlaying: initialData.isPlaying,
      isFullPlayerOn: initialData.isFullPlayerOn,
    );
  }
}

/// Helper which enforces our rule that our `song` and `progress` must either
/// both be `null`, or both have a real value.
@freezed
class SongWithProgress with _$SongWithProgress {
  const factory SongWithProgress({
    required Duration progress,
    required Song song,
  }) = _SongWithProgress;
}
