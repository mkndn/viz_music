import 'package:myartist/src/shared/classes/song.dart';
import 'package:myartist/src/shared/enums/repeat_mode.dart';

class PlayerStateModel {
  List<Song> queue;
  int currentIndex;
  Duration progress;
  double volume;
  double? previousVolume;
  bool isMuted;
  bool isPlaying;
  bool isFullPlayerOn;
  RepeatMode repeatMode;

  PlayerStateModel({
    required this.queue,
    required this.currentIndex,
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
