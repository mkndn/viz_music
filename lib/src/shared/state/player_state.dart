import 'package:mkndn/src/shared/classes/song_queue.dart';
import 'package:mkndn/src/shared/enums/repeat_mode.dart';

class PlayerStateModel {
  SongQueue queue;
  Duration progress;
  double volume;
  double? previousVolume;
  bool isMuted;
  bool isPlaying;
  bool isFullPlayerOn;
  RepeatMode repeatMode;

  PlayerStateModel({
    required this.queue,
    this.previousVolume,
    Duration? progressParam,
    double? volumeParam,
    bool? isMutedParam,
    bool? isPlayingParam,
    bool? isFullPlayerOnParam,
    RepeatMode? repeatModeParam,
  })  : progress = progressParam ?? const Duration(),
        volume = volumeParam ?? 0.5,
        isMuted = isMutedParam ?? false,
        isPlaying = isPlayingParam ?? false,
        isFullPlayerOn = isFullPlayerOnParam ?? false,
        repeatMode = repeatModeParam ?? RepeatMode.noRepeat;
}
