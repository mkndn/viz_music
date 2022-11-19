import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mkndn/src/shared/classes/song_queue.dart';
import 'package:mkndn/src/shared/enums/repeat_mode.dart';
import 'package:mkndn/src/shared/models/song.dart';
import 'package:mkndn/src/shared/services/disk_state_storage_manager.dart';
import 'package:mkndn/src/shared/state/player_state.dart';

part 'playback_event.dart';
part 'playback_state.dart';
part 'playback_bloc.freezed.dart';
part 'playback_bloc.g.dart';

class PlaybackBloc extends Bloc<PlaybackEvent, PlaybackState> {
  final AudioPlayer _player = AudioPlayer();
  static final DiskStateStorageManager _stateStorageManager =
      DiskStateStorageManager.instance();

  PlaybackBloc() : super(PlaybackState.load(_stateStorageManager.loadData())) {
    if (state.queue.songWithProgress?.progress != null) {
      _player.seek(state.queue.songWithProgress!.progress);
    }
    on<PlaybackEvent>(
      (event, emit) => event.map(
        nextQueue: (event) => _nextQueue(event, emit),
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
  StreamSubscription<Duration>? _currentlyPlayingSubscription;

  Stream<Duration> _startPlayingStream() async* {
    while (state.queue.songWithProgress!.progress <
        state.queue.songWithProgress!.song.length) {
      await Future<void>.delayed(_playbackUpdateInterval);
      yield _playbackUpdateInterval;
      if (state.queue.songWithProgress!.progress >=
          state.queue.songWithProgress!.song.length) {
        add(PlaybackEvent.nextQueue());
        break;
      }
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
    _player.pause();
    _currentlyPlayingSubscription!.cancel();
  }

  void _resumePlayback() {
    _currentlyPlayingSubscription =
        _startPlayingStream().listen(_handlePlaybackProgress);
    if (state.queue.songWithProgress?.song != null) {
      _player.play(
        DeviceFileSource(state.queue.songWithProgress!.song.path),
        mode: PlayerMode.mediaPlayer,
      );
    }
  }

  void _nextQueue(NextQueue event, Emitter<PlaybackState> emit) {
    SongQueue? nextQueue = state.queue.getNext(state.repeatMode.idx);
    if (nextQueue == null) {
      PlaybackEvent.togglePlayPause();
    } else {
      _changeSong(nextQueue, emit);
    }
  }

  void _changeSong(SongQueue nextQueue, Emitter<PlaybackState> emit) {
    if (_currentlyPlayingSubscription != null) {
      _currentlyPlayingSubscription!.cancel();
    }
    emit(
      state.copyWith(
        isPlaying: true,
        queue: nextQueue,
      ),
    );
    _resumePlayback();
  }

  void _songProgress(SongProgress event, Emitter<PlaybackState> emit) {
    emit(
      state.copyWith(
        queue: state.queue.copyWith(
          songWithProgress: state.queue.songWithProgress!.copyWith(
            progress: state.queue.songWithProgress!.progress + event.duration,
          ),
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
    _player.setVolume(event.value);
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
        state.queue.songWithProgress!.song.length.inMilliseconds *
            event.percent;
    final progressDuration = Duration(milliseconds: targetMilliseconds.toInt());
    emit(
      state.copyWith(
        isPlaying: false,
        queue: state.queue.copyWith(
          songWithProgress: state.queue.songWithProgress!.copyWith(
            progress: progressDuration,
          ),
        ),
      ),
    );
    _player.seek(Duration(milliseconds: targetMilliseconds.toInt()));
  }

  @override
  Future<void> close() async {
    await _currentlyPlayingSubscription?.cancel();
    await super.close();
  }
}
