import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myartist/src/shared/enums/repeat_mode.dart';
import 'package:myartist/src/shared/services/disk_state_storage_manager.dart';
import 'package:myartist/src/shared/state/player_state.dart';
import '../../classes/classes.dart';

part 'playback_event.dart';
part 'playback_state.dart';
part 'playback_bloc.freezed.dart';

class PlaybackBloc extends Bloc<PlaybackEvent, PlaybackState> {
  final AudioPlayer player = AudioPlayer();
  static final DiskStateStorageManager stateStorageManager =
      DiskStateStorageManager.instance();

  PlaybackBloc() : super(PlaybackState.load(stateStorageManager.loadData())) {
    if (state.songWithProgress?.progress != null) {
      player.seek(state.songWithProgress!.progress);
    }
    on<PlaybackEvent>(
      (event, emit) => event.map(
        initQueue: (event) => _initQueue(event, emit),
        changeSong: (event) => _changeSong(event, emit),
        moveToInSong: (event) => _moveToInSong(event, emit),
        setVolume: (event) => _setVolume(event, emit),
        songProgress: (event) => _songProgress(event, emit),
        toggleMute: (event) => _toggleMute(event, emit),
        toggleFullPlayer: (event) => _toggleFullPlayer(event, emit),
        togglePlayPause: (event) => _togglePlayPause(event, emit),
        changeRepeatMode: (event) => _changeRepeatMode(event, emit),
      ),
    );
  }

  static const _playbackUpdateInterval = Duration(seconds: 1);
  StreamSubscription<Duration>? currentlyPlayingSubscription;

  Stream<Duration> _startPlayingStream() async* {
    while (state.songWithProgress!.progress <
        state.songWithProgress!.song.length) {
      await Future<void>.delayed(_playbackUpdateInterval);
      yield _playbackUpdateInterval;
      if (state.songWithProgress!.progress >=
          state.songWithProgress!.song.length) {
        add(getEventByRepeatMode());
        break;
      }
    }
  }

  PlaybackEvent getEventByRepeatMode() {
    if (state.repeatMode.idx == 0) {
      if (state.currentIndex == state.queue.length - 1) {
        return PlaybackEvent.togglePlayPause();
      } else {
        return PlaybackEvent.changeSong(state.currentIndex + 1);
      }
    }
    if (state.repeatMode.idx == 1) {
      return PlaybackEvent.changeSong(state.currentIndex);
    }

    if (state.currentIndex == state.queue.length - 1) {
      return PlaybackEvent.changeSong(0);
    } else {
      return PlaybackEvent.changeSong(state.currentIndex + 1);
    }
  }

  void _handlePlaybackProgress(Duration progress) {
    add(
      PlaybackEvent.songProgress(progress),
    );
  }

  void _togglePlayPause(TogglePlayPause event, Emitter<PlaybackState> emit) {
    state.isPlaying ? _pausePlayback() : _resumePlayback();
    emit(state.copyWith(isPlaying: !state.isPlaying));
  }

  void _pausePlayback() {
    player.pause();
    currentlyPlayingSubscription!.cancel();
  }

  void _resumePlayback() {
    currentlyPlayingSubscription =
        _startPlayingStream().listen(_handlePlaybackProgress);
    if (state.songWithProgress?.song != null) {
      player.play(
        DeviceFileSource(state.songWithProgress!.song.path),
        mode: PlayerMode.mediaPlayer,
      );
    }
  }

  void _initQueue(InitQueue event, Emitter<PlaybackState> emit) {
    emit(
      state.copyWith(
        isPlaying: true,
        queue: event.queue,
        currentIndex: event.currentIndex,
        songWithProgress: SongWithProgress(
          progress: const Duration(),
          song: event.queue[event.currentIndex],
        ),
      ),
    );
    _resumePlayback();
  }

  void _changeSong(ChangeSong event, Emitter<PlaybackState> emit) {
    if (currentlyPlayingSubscription != null) {
      currentlyPlayingSubscription!.cancel();
    }
    emit(
      state.copyWith(
        isPlaying: true,
        currentIndex: event.index,
        songWithProgress: SongWithProgress(
          progress: const Duration(),
          song: state.queue[event.index],
        ),
      ),
    );
    _resumePlayback();
  }

  void _songProgress(SongProgress event, Emitter<PlaybackState> emit) {
    emit(
      state.copyWith(
        songWithProgress: state.songWithProgress!.copyWith(
          progress: state.songWithProgress!.progress + event.duration,
        ),
      ),
    );
  }

  void _setVolume(SetVolume event, Emitter<PlaybackState> emit) {
    emit(
      state.copyWith(
        volume: event.value,
        isMuted: false,
        previousVolume: null,
      ),
    );
    player.setVolume(event.value);
  }

  void _toggleMute(ToggleMute event, Emitter<PlaybackState> emit) {
    if (state.isMuted) {
      emit(
        state.copyWith(
          isMuted: false,
          volume: state.previousVolume!,
          previousVolume: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          isMuted: true,
          volume: 0,
          previousVolume: state.volume,
        ),
      );
    }
  }

  void _toggleFullPlayer(ToggleFullPlayer event, Emitter<PlaybackState> emit) {
    emit(
      state.copyWith(isFullPlayerOn: !state.isFullPlayerOn),
    );
  }

  void _changeRepeatMode(ChangeRepeatMode event, Emitter<PlaybackState> emit) {
    RepeatMode newRepeatMode = state.repeatMode.nextById();
    emit(
      state.copyWith(repeatMode: newRepeatMode),
    );
  }

  void _moveToInSong(MoveToInSong event, Emitter<PlaybackState> emit) {
    _pausePlayback();
    final targetMilliseconds =
        state.songWithProgress!.song.length.inMilliseconds * event.percent;
    final progressDuration = Duration(milliseconds: targetMilliseconds.toInt());
    emit(
      state.copyWith(
        isPlaying: false,
        songWithProgress: state.songWithProgress!.copyWith(
          progress: progressDuration,
        ),
      ),
    );
    player.seek(Duration(milliseconds: targetMilliseconds.toInt()));
  }

  @override
  Future<void> close() async {
    await currentlyPlayingSubscription?.cancel();
    await super.close();
  }
}
