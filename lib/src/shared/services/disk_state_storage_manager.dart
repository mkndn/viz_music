import 'package:mkndn/src/shared/classes/song_queue.dart';
import 'package:mkndn/src/shared/enums/repeat_mode.dart';
import 'package:mkndn/src/shared/enums/state.dart';
import 'package:mkndn/src/shared/playback/bloc/bloc.dart';
import 'package:mkndn/src/shared/services/hive_services.dart';
import 'package:mkndn/src/shared/services/player_state_service.dart';
import 'package:mkndn/src/shared/state/player_state.dart';
import 'package:mkndn/src/shared/typedefs.dart';

class DiskStateStorageManager {
  final HiveService<String, dynamic> playerStateService;

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
    final queue =
        playerStateService.getItem(PlayerStateKey.queue.name) as SongQueue?;
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
      queue: queue ?? SongQueue.instance(),
      repeatModeParam:
          repeatMode ?? RepeatMode.of(repeatMode, RepeatMode.noRepeat),
      progressParam: progress,
      volumeParam: castOrFallback<double>(volume, 0.5),
      previousVolume: castOrNull<double>(previousVolume),
      isMutedParam: castOrNull<bool>(isMuted),
      isPlayingParam: castOrNull<bool>(isPlaying),
      isFullPlayerOnParam: castOrNull<bool>(isFullPlayerOn),
    );
  }

  void persistState(PlaybackState state) {
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
