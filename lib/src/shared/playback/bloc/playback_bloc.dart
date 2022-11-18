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

class PlaybackBloc extends Bloc<PlaybackEvent, PlaybackState> {
  final AudioPlayer _player = AudioPlayer();
  static final DiskStateStorageManager _stateStorageManager =
      DiskStateStorageManager.instance();

  PlaybackBloc() : super(PlaybackState.load(_stateStorageManager.loadData())) {
    if (state.songWithProgress?.progress != null) {
      _player.seek(state.songWithProgress!.progress);
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
  StreamSubscription<Duration>? _currentlyPlayingSubscription;

  Stream<Duration> _startPlayingStream() async* {
    while (state.songWithProgress!.progress <
        state.songWithProgress!.song.length) {
      await Future<void>.delayed(_playbackUpdateInterval);
      yield _playbackUpdateInterval;
      if (state.songWithProgress!.progress >=
          state.songWithProgress!.song.length) {
        add(_getEventByRepeatMode(true));
        break;
      }
    }
  }

  PlaybackEvent _getEventByRepeatMode(bool isAutoMode) {
    if (state.repeatMode.idx == 0) {
      if (state.queue.isLastSong) {
        return PlaybackEvent.togglePlayPause();
      } else {
        return PlaybackEvent.changeSong(state.queue.getNextSong());
      }
    }
    if (state.repeatMode.idx == 1) {
      return PlaybackEvent.changeSong(state.queue.currentSong);
    }

    if (state.queue.isLastSong) {
      return PlaybackEvent.changeSong(state.queue.getFirstSong());
    } else {
      return PlaybackEvent.changeSong(state.queue.getNextSong());
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
    if (state.songWithProgress?.song != null) {
      _player.play(
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
        songWithProgress: SongWithProgress(
          progress: const Duration(),
          song: event.queue.currentSong,
        ),
      ),
    );
    _resumePlayback();
  }

  void _changeSong(ChangeSong event, Emitter<PlaybackState> emit) {
    if (_currentlyPlayingSubscription != null) {
      _currentlyPlayingSubscription!.cancel();
    }
    emit(
      state.copyWith(
        isPlaying: true,
        songWithProgress: SongWithProgress(
          progress: const Duration(),
          song: event.song,
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
    _player.seek(Duration(milliseconds: targetMilliseconds.toInt()));
  }

  @override
  Future<void> close() async {
    await _currentlyPlayingSubscription?.cancel();
    await super.close();
  }
}
