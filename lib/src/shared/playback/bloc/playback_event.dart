part of 'playback_bloc.dart';

@Freezed()
class PlaybackEvent with _$PlaybackEvent {
  const factory PlaybackEvent.togglePlayPause() = TogglePlayPause;
  const factory PlaybackEvent.initQueue(SongQueue songQueue) = InitQueue;
  const factory PlaybackEvent.addToQueue(Song song) = AddToQueue;
  const factory PlaybackEvent.nextInQueue() = NextInQueue;
  const factory PlaybackEvent.changeSong(String songId) = ChangeSong;
  const factory PlaybackEvent.setVolume(double value) = SetVolume;
  const factory PlaybackEvent.toggleMute() = ToggleMute;
  const factory PlaybackEvent.toggleFullPlayer() = ToggleFullPlayer;
  const factory PlaybackEvent.changeRepeatMode() = ChangeRepeatMode;

  /// Used to move to a specific timestamp in a song, likely because the user
  /// has dragged the playback bar. Values should be between 0 and 1.
  const factory PlaybackEvent.moveToInSong(double percent) = MoveToInSong;

  /// Used to indicate incremental progress in the song that is currently
  /// playing.
  const factory PlaybackEvent.songProgress(Duration duration) = SongProgress;
}
