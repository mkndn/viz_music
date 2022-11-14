import 'package:myartist/src/shared/classes/classes.dart';
import 'package:myartist/src/shared/enums/repeat_mode.dart';
import 'package:myartist/src/shared/enums/state.dart';
import 'package:myartist/src/shared/playback/bloc/bloc.dart';
import 'package:myartist/src/shared/services/hive_services.dart';
import 'package:myartist/src/shared/services/player_state_service.dart';
import 'package:myartist/src/shared/state/player_state.dart';
import 'package:myartist/src/shared/typedefs.dart';

class DiskStateStorageManager {
  final HiveService<dynamic> playerStateService;

  static final DiskStateStorageManager _instance = DiskStateStorageManager._(
    playerStateService: PlayerStateService.instance(),
  );

  DiskStateStorageManager._({required this.playerStateService});

  static DiskStateStorageManager instance() {
    return _instance;
  }

  void resetAll() {
    playerStateService.resetBox();
  }

  PlayerStateModel loadData() {
    final queue = playerStateService.getItem(PlayerStateKey.queue.name);
    final currentIndex =
        playerStateService.getItem(PlayerStateKey.currentIndex.name);
    final progress = playerStateService.getItem(PlayerStateKey.progress.name);
    final repeatMode =
        playerStateService.getItem(PlayerStateKey.repeatMode.name);
    final volume = playerStateService.getItem(PlayerStateKey.volume.name);
    final previousVolume =
        playerStateService.getItem(PlayerStateKey.previousVolume.name);
    final isMuted = playerStateService.getItem(PlayerStateKey.isMuted.name);
    final isPlaying = playerStateService.getItem(PlayerStateKey.isPlaying.name);
    final isFullPlayerOn =
        playerStateService.getItem(PlayerStateKey.isFullPlayerOn.name);
    return PlayerStateModel(
      queue: queue != null
          ? List.castFrom(queue)
          : List<Song>.empty(growable: true),
      repeatModeParam:
          repeatMode ?? RepeatMode.of(repeatMode, RepeatMode.noRepeat),
      currentIndex: castOrFallback<int>(currentIndex, 0),
      progressParam: progress,
      volumeParam: castOrFallback<double>(volume, 0.5),
      previousVolume: castOrNull<double>(previousVolume),
      isMutedParam: castOrNull<bool>(isMuted),
      isPlayingParam: castOrNull<bool>(isPlaying),
      isFullPlayerOnParam: castOrNull<bool>(isFullPlayerOn),
    );
  }

  void persistState(PlaybackState state) {
    persistItem(PlayerStateKey.currentIndex, state.currentIndex);
    persistItem(PlayerStateKey.queue, state.queue);
    persistItem(PlayerStateKey.progress, state.songWithProgress?.progress);
    persistItem(PlayerStateKey.repeatMode, state.repeatMode);
    persistItem(PlayerStateKey.volume, state.volume);
    persistItem(PlayerStateKey.previousVolume, state.previousVolume);
    persistItem(PlayerStateKey.isFullPlayerOn, state.isFullPlayerOn);
    persistItem(PlayerStateKey.isMuted, state.isMuted);
    persistItem(PlayerStateKey.isPlaying, state.isPlaying);
  }

  void persistItem(PlayerStateKey key, dynamic value) {
    playerStateService.addItemToBox(item: value, key: key.name);
  }
}
