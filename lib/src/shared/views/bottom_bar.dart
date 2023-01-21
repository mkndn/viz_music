import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/shared/classes/artist.dart';
import 'package:mkndn/src/shared/enums/repeat_mode.dart';
import 'package:mkndn/src/shared/life_cycle_event_handler.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/services/disk_state_storage_manager.dart';
import 'package:mkndn/src/shared/state/inmemory_media_manager.dart';
import 'package:mkndn/src/shared/typedefs.dart';
import 'package:mkndn/src/shared/views/bottom_bar_song_overlay.dart';

import '../classes/classes.dart';
import '../extensions.dart';
import '../playback/bloc/bloc.dart';
import '../providers/providers.dart';
import 'image_clipper.dart';

/// Currently-playing informational bar that always spans the entire bottom
/// of the UI.
class BottomBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomBar({required this.mediaManagerState, super.key});

  final InMemoryMediaManagerState mediaManagerState;

  @override
  Size get preferredSize => const Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PlaybackBloc>(context);
    return BlocBuilder<PlaybackBloc, PlaybackState>(
      bloc: bloc,
      builder: (context, state) {
        return _BottomBar(
          mediaManagerState: mediaManagerState,
          isMuted: state.isMuted,
          isPlaying: state.isPlaying,
          isFullPlayerOn: state.isFullPlayerOn,
          repeatMode: state.repeatMode,
          preferredSize: preferredSize,
          queue: state.queue,
          persistState: (manager) => manager.persistState(state),
          songWithProgress: state.queue.songWithProgress,
          progress: state.queue.songWithProgress?.progress,
          togglePlayPause: () => bloc.add(
            const PlaybackEvent.togglePlayPause(),
          ),
          nextQueue: () => bloc.add(PlaybackEvent.nextInQueue()),
          toggleFullPlayer: () => bloc.add(
            const PlaybackEvent.toggleFullPlayer(),
          ),
          changeRepeatMode: () => bloc.add(
            const PlaybackEvent.changeRepeatMode(),
          ),
          volume: state.volume,
        );
      },
    );
  }
}

class _BottomBar extends StatefulWidget {
  const _BottomBar({
    required this.mediaManagerState,
    required this.isMuted,
    required this.isPlaying,
    required this.isFullPlayerOn,
    required this.repeatMode,
    required this.preferredSize,
    required this.queue,
    required this.togglePlayPause,
    required this.toggleFullPlayer,
    required this.changeRepeatMode,
    required this.nextQueue,
    required this.volume,
    required this.persistState,
    this.progress,
    this.songWithProgress,
  });

  final InMemoryMediaManagerState mediaManagerState;
  final bool isMuted;
  final bool isPlaying;
  final bool isFullPlayerOn;
  final RepeatMode repeatMode;
  final Size preferredSize;
  final SongQueue queue;
  final SongWithProgress? songWithProgress;
  final Duration? progress;
  final VoidCallback togglePlayPause;
  final VoidCallback toggleFullPlayer;
  final VoidCallback changeRepeatMode;
  final VoidCallback nextQueue;
  final Consumer<DiskStateStorageManager> persistState;
  final double volume;

  @override
  State<_BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<_BottomBar> {
  DiskStateStorageManager stateStorageManager =
      DiskStateStorageManager.instance();
  OverlayState? _overlayState = null;
  OverlayEntry? _fullScreenPlayerOverlay = null;
  OverlayEntry? _songlistOverlay = null;
  ValueNotifier<bool> _isSonglistLoaded = ValueNotifier<bool>(false);
  StreamSubscription<Duration>? _rankMediaStreamSubscription;
  late MediaContent _info;

  Future<void> handleRankMedia(
    Duration currentProgress,
  ) async {
    if (widget.songWithProgress != null) {
      if (widget.songWithProgress!.progress.inMilliseconds >
          widget.songWithProgress!.song.length.inMilliseconds * 0.05) {
        widget.mediaManagerState.rankMedia(widget.songWithProgress!.song.title);
        await _rankMediaStreamSubscription!.cancel();
      }
    }
  }

  void _buildSonglistOverlay(
      BuildContext context, SongQueue queue, Size parentSize) {
    this._songlistOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
            left: 200,
            child: BottomBarSongOverlay(
              parentSize: parentSize,
              queue: queue,
            ),
          ),
        ],
      ),
    );
  }

  void _renderSonglistOverlay() {
    if (this._songlistOverlay != null && this._overlayState != null) {
      if (!this._songlistOverlay!.mounted) {
        this._overlayState!.insert(this._songlistOverlay!);
        _isSonglistLoaded.value = true;
      } else if (this._songlistOverlay!.mounted) {
        this._songlistOverlay!.remove();
        _isSonglistLoaded.value = false;
      }
    }
  }

  void buildFullScreenPlayerOverlay(BuildContext context) {
    this._fullScreenPlayerOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
            child: _FullScreenPlayer(
                info: _info,
                onClose: closeFullScreenPlayerOverlay,
                renderSonglist: _renderSonglistOverlay,
                songlistLoaded: _isSonglistLoaded),
          ),
        ],
      ),
    );
    loadFullScreenPlayerOverlay();
  }

  void closeFullScreenPlayerOverlay() {
    if (this._fullScreenPlayerOverlay != null) {
      this._fullScreenPlayerOverlay!.remove();
      widget.toggleFullPlayer();
    }
  }

  void loadFullScreenPlayerOverlay() {
    if (this._overlayState != null && this._fullScreenPlayerOverlay != null) {
      this._overlayState!.insert(this._fullScreenPlayerOverlay!);
      widget.toggleFullPlayer();
    }
  }

  @override
  void initState() {
    super.initState();
    _info = widget.mediaManagerState.content;
    WidgetsBinding.instance.addObserver(LifeCycleEventHandler(
        resumeCallBack: () async => {},
        detachedCallBack: () async =>
            widget.persistState(stateStorageManager)));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this._overlayState = Overlay.of(context);
      _buildSonglistOverlay(context, widget.queue, widget.preferredSize);
      if (widget.isFullPlayerOn) buildFullScreenPlayerOverlay(context);
    });
  }

  @override
  void dispose() {
    if (widget.isPlaying) {
      PlaybackEvent.togglePlayPause();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => constraints.isTablet
            ? _buildDesktopBar(context, constraints)
            : _buildMobileBar(context, constraints),
      );

  Widget _buildDesktopBar(BuildContext context, BoxConstraints constraints) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox.fromSize(
        size: widget.preferredSize,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                _AlbumArt(song: widget.songWithProgress?.song),
                _SongDetails(
                  artist: widget.songWithProgress?.song.artist != null
                      ? _info.getArtistByTitle(
                          widget.songWithProgress!.song.artist)
                      : null,
                  song: widget.songWithProgress?.song,
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  _PlaybackControls(
                    key: Key("SonglistPlayerKey"),
                    isPlaying: widget.isPlaying,
                    togglePlayPause: widget.togglePlayPause,
                    changeRepeatMode: widget.changeRepeatMode,
                    nextQueue: widget.nextQueue,
                    queue: widget.queue,
                    repeatMode: widget.repeatMode,
                    songlistValue: _isSonglistLoaded,
                    renderSonglist: _renderSonglistOverlay,
                  ),
                  Center(
                    child: _ProgressBar(
                      progress: widget.progress,
                      song: widget.songWithProgress?.song,
                    ),
                  ),
                ],
              ),
            ),
            if (constraints.isDesktop) ...[
              _VolumeBar(volume: widget.volume, isMuted: widget.isMuted),
            ],
            if (widget.songWithProgress?.song != null)
              IconButton(
                icon: const Icon(Icons.fullscreen),
                onPressed: () {
                  if (widget.isFullPlayerOn) {
                    closeFullScreenPlayerOverlay();
                  } else {
                    buildFullScreenPlayerOverlay(context);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  double get songProgress =>
      widget.progress != null && widget.songWithProgress?.song != null
          ? widget.progress!.inMilliseconds /
              widget.songWithProgress!.song.length.inMilliseconds
          : 0;

  Widget _buildMobileBar(BuildContext context, BoxConstraints constraints) {
    final Artist? artist = widget.songWithProgress?.song.artist != null
        ? _info.getArtistByTitle(widget.songWithProgress!.song.artist)
        : null;
    return ColoredBox(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: SizedBox(
        height: kToolbarHeight,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            final overlay = Overlay.of(context);
            OverlayEntry? entry;
            entry = OverlayEntry(
              builder: (context) => Stack(
                children: [
                  Positioned(
                    child: _MobilePlayer(
                      info: _info,
                      renderSonglist: _renderSonglistOverlay,
                      songlistValue: _isSonglistLoaded,
                      onClose: () {
                        entry?.remove();
                      },
                    ),
                  ),
                ],
              ),
            );
            overlay!.insert(entry);
          },
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 4,
                bottom: 0,
                child: LinearProgressIndicator(
                  value: songProgress.clamp(0, 1),
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
              Positioned(
                left: 4,
                bottom: 4,
                top: 4,
                right: 4,
                child: Row(
                  children: [
                    _AlbumArt(song: widget.songWithProgress?.song),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.songWithProgress?.song.title ?? '',
                          style: context.labelMedium,
                        ),
                        Text(
                          artist?.title ?? '',
                          style: context.labelSmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: widget.togglePlayPause,
                      icon: Icon(
                        widget.isPlaying
                            ? Icons.pause_circle
                            : Icons.play_circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    required this.progress,
    required this.song,
  });

  /// Current playback depth into user is into [song].
  final Duration? progress;

  final Song? song;

  double get songProgress => progress != null && song != null
      ? progress!.inMilliseconds / song!.length.inMilliseconds
      : 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        late EdgeInsets padding = EdgeInsets.zero;
        if (constraints.maxWidth > 500) {
          padding = const EdgeInsets.symmetric(horizontal: 50);
        } else if (constraints.maxWidth < 350) {
          padding = const EdgeInsets.symmetric(horizontal: 25);
        } else {
          padding = const EdgeInsets.symmetric(horizontal: 20);
        }
        return Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                child: progress != null
                    ? Text(progress!.toHumanizedString(),
                        style: Theme.of(context).textTheme.bodySmall)
                    : const Text('-'),
              ),
              Expanded(
                child: Slider(
                  value: songProgress.clamp(0, 1),
                  divisions: 1000,
                  onChanged: (percent) {
                    BlocProvider.of<PlaybackBloc>(context).add(
                      PlaybackEvent.moveToInSong(percent),
                    );
                  },
                  onChangeEnd: (percent) {
                    BlocProvider.of<PlaybackBloc>(context).add(
                      PlaybackEvent.moveToInSong(percent),
                    );
                    // Because dragging pauses auto playback, resume playing
                    // once the user finishes dragging.
                    BlocProvider.of<PlaybackBloc>(context).add(
                      const PlaybackEvent.togglePlayPause(),
                    );
                  },
                  activeColor:
                      Theme.of(context).colorScheme.onTertiaryContainer,
                  inactiveColor: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(
                child: song != null
                    ? Text(song!.length.toHumanizedString(),
                        style: Theme.of(context).textTheme.bodySmall)
                    : const Text('-'),
              ),
              const SizedBox(width: 10)
            ],
          ),
        );
      },
    );
  }
}

class _VolumeBar extends StatelessWidget {
  const _VolumeBar({
    required this.volume,
    required this.isMuted,
  });

  /// The percentage, between 0 and 1, at which to render the volume slider.
  final double volume;

  /// True if the user has explicitly pressed the mute button. The value for
  /// [volume] can be zero without this also being `true`, but if this is `true`,
  /// then the value for [volume] will always be zero.
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => BlocProvider.of<PlaybackBloc>(context).add(
                const PlaybackEvent.toggleMute(),
              ),
              child: Icon(!isMuted ? Icons.volume_mute : Icons.volume_off),
            ),
            Expanded(
              child: Slider(
                value: volume,
                min: 0,
                max: 1,
                divisions: 100,
                onChanged: (newValue) => BlocProvider.of<PlaybackBloc>(context)
                    .add(PlaybackEvent.setVolume(newValue)),
                activeColor: Theme.of(context).colorScheme.onTertiaryContainer,
                inactiveColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaybackControls extends StatelessWidget {
  const _PlaybackControls({
    required Key key,
    required this.isPlaying,
    required this.togglePlayPause,
    required this.changeRepeatMode,
    required this.nextQueue,
    required this.queue,
    required this.repeatMode,
    required this.renderSonglist,
    required this.songlistValue,
  }) : super(key: key);

  final bool isPlaying;
  final VoidCallback togglePlayPause;
  final VoidCallback changeRepeatMode;
  final VoidCallback nextQueue;
  final SongQueue queue;
  final RepeatMode repeatMode;
  final VoidCallback renderSonglist;
  final ValueNotifier<bool> songlistValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double iconSize = 24;
      double playIconSize = 32;
      double innerPadding = 16;
      double playPadding = 20;
      if (constraints.maxWidth < 500) {
        iconSize = 21;
        playIconSize = 28;
        innerPadding = 14;
        playPadding = 17;
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 0, innerPadding, 0),
              child: Icon(Icons.shuffle, size: 20)),
          IconButton(
            icon: Icon(Icons.skip_previous, size: iconSize),
            onPressed: () => queue.getPreviousSong(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(playPadding, 0, innerPadding, 0),
            child: IconButton(
              onPressed: togglePlayPause,
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                size: playIconSize,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.skip_next, size: iconSize),
            onPressed: () => nextQueue(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(innerPadding, 0, 0, 0),
            child: IconButton(
              onPressed: changeRepeatMode,
              icon: repeatMode.icon,
              iconSize: iconSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(innerPadding, 0, 0, 0),
            child: ValueListenableBuilder<bool>(
              valueListenable: songlistValue,
              builder: (context, value, _) => IconButton(
                icon: Icon(value ? Icons.close : Icons.queue_music_rounded,
                    size: iconSize),
                onPressed: renderSonglist,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _AlbumArt extends StatelessWidget {
  const _AlbumArt({
    required this.song,
  });

  final Song? song;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: 70,
        height: 70,
        child: song != null
            ? Image.memory(song!.albumCover)
            : Container(
                color: Colors.pink[100],
              ),
      ),
    );
  }
}

class _SongDetails extends StatelessWidget {
  const _SongDetails({
    required this.artist,
    required this.song,
  });

  final Artist? artist;
  final Song? song;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song != null ? song!.title : '-',
              style: context.labelLarge!.copyWith(fontSize: 12),
              overflow: TextOverflow.clip,
              maxLines: 1,
            ),
            Text(
              artist != null ? artist!.title : '-',
              style: context.labelSmall!.copyWith(fontSize: 8),
              overflow: TextOverflow.clip,
            ),
          ],
        );
      },
    );
  }
}

class _FullScreenPlayer extends StatefulWidget {
  const _FullScreenPlayer({
    required this.info,
    required this.onClose,
    required this.renderSonglist,
    required this.songlistLoaded,
  });

  final MediaContent info;
  final VoidCallback onClose;
  final VoidCallback renderSonglist;
  final ValueNotifier<bool> songlistLoaded;

  @override
  State<_FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<_FullScreenPlayer> {
  bool _showControls = true;
  Timer? _controlsTimer;

  void hideControls() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      if (this.mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    hideControls();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PlaybackBloc>(context);
    return BlocBuilder<PlaybackBloc, PlaybackState>(
      bloc: bloc,
      builder: (context, state) => Theme(
        data: ThemeProvider.of(context).dark(),
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, dimens) {
              return MouseRegion(
                onHover: (_) {
                  setState(() {
                    _showControls = true;
                  });
                  hideControls();
                },
                child: buildPlayer(context, state, dimens),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildPlayer(
      BuildContext context, PlaybackState state, BoxConstraints dimens) {
    final bloc = BlocProvider.of<PlaybackBloc>(context);
    final current = state.queue.songWithProgress;
    final song = current?.song;
    final queue = state.queue;
    final repeatMode = state.repeatMode;
    final Artist? artist = song?.artist != null
        ? widget.info.getArtistByTitle(song!.artist)
        : null;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: current == null
              ? const Center(child: Text('No song selected'))
              : Container(
                  color: context.colors.shadow,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.memory(
                      song!.albumCover,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: IconButton(
            color: song != null
                ? context.colors.onSurface
                : context.colors.onBackground,
            icon: const Icon(Icons.fullscreen_exit),
            onPressed: () {
              widget.onClose();
            },
          ),
        ),
        if (song != null) ...[
          Positioned(
            left: 60,
            bottom: dimens.biggest.height * 0.28,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: dimens.biggest.height * 0.2,
                  child: ClippedImage(song.albumCover),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      style: context.labelLarge!.copyWith(fontSize: 42),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                    Text(
                      artist?.title ?? '',
                      style: context.labelSmall!.copyWith(
                          fontSize: 20,
                          color: context.colors.onSurface.withOpacity(0.8)),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            left: 20,
            bottom: dimens.biggest.height * 0.2,
            child: _ProgressBar(
              progress: current?.progress,
              song: song,
            ),
          ),
          Positioned(
            right: 20,
            left: 20,
            bottom: dimens.biggest.height * 0.1,
            child: AnimatedOpacity(
              duration: kThemeAnimationDuration,
              opacity: _showControls ? 1 : 0,
              child: Transform.scale(
                scale: 1.5,
                child: _PlaybackControls(
                  key: Key("FullScreenDesktopPlayerKey"),
                  isPlaying: state.isPlaying,
                  togglePlayPause: () =>
                      bloc.add(const PlaybackEvent.togglePlayPause()),
                  nextQueue: () => bloc.add(PlaybackEvent.nextInQueue()),
                  changeRepeatMode: () =>
                      bloc.add(const PlaybackEvent.changeRepeatMode()),
                  queue: queue,
                  repeatMode: repeatMode,
                  renderSonglist: widget.renderSonglist,
                  songlistValue: widget.songlistLoaded,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _MobilePlayer extends StatelessWidget {
  const _MobilePlayer({
    required this.info,
    required this.onClose,
    required this.renderSonglist,
    required this.songlistValue,
  });

  final MediaContent info;
  final VoidCallback onClose;
  final VoidCallback renderSonglist;
  final ValueNotifier<bool> songlistValue;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PlaybackBloc>(context);
    return BlocBuilder<PlaybackBloc, PlaybackState>(
      bloc: bloc,
      builder: (context, state) => Theme(
        data: ThemeProvider.of(context).dark(),
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, dimens) {
              return buildPlayer(context, state, dimens);
            },
          ),
        ),
      ),
    );
  }

  Widget buildPlayer(
      BuildContext context, PlaybackState state, BoxConstraints dimens) {
    final bloc = BlocProvider.of<PlaybackBloc>(context);
    final current = state.queue.songWithProgress;
    final queue = state.queue;
    final repeatMode = state.repeatMode;
    final Artist? artist = current?.song.artist != null
        ? info.getArtistByTitle(current!.song.artist)
        : null;
    return Stack(
      children: [
        Positioned.fill(
          child: current == null
              ? const Center(child: Text('No song selected'))
              : Container(
                  color: context.colors.shadow,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.memory(
                      current.song.albumCover,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: IconButton(
            color: current?.song != null
                ? context.colors.onSurface
                : context.colors.onBackground,
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(Icons.chevron_right),
            ),
            onPressed: onClose,
          ),
        ),
        if (current != null) ...[
          if (dimens.biggest.height > 500)
            Positioned(
              top: kToolbarHeight,
              left: 0,
              right: 0,
              height: dimens.biggest.height * 0.5,
              child: Image.memory(
                current.song.albumCover,
                fit: BoxFit.contain,
              ),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: dimens.biggest.height * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        current.song.title,
                        style: context.labelLarge!.copyWith(fontSize: 22),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      Text(
                        artist?.title ?? '',
                        style: context.labelSmall!.copyWith(
                            fontSize: 12,
                            color: context.colors.onSurface.withOpacity(0.8)),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Transform.scale(
                    scale: 1.5,
                    child: _PlaybackControls(
                      key: Key("FullScreenMobilePlayerKey"),
                      isPlaying: state.isPlaying,
                      togglePlayPause: () =>
                          bloc.add(const PlaybackEvent.togglePlayPause()),
                      nextQueue: () => bloc.add(PlaybackEvent.nextInQueue()),
                      changeRepeatMode: () =>
                          bloc.add(const PlaybackEvent.changeRepeatMode()),
                      queue: queue,
                      repeatMode: repeatMode,
                      renderSonglist: renderSonglist,
                      songlistValue: songlistValue,
                    ),
                  ),
                ),
                _ProgressBar(
                  progress: current.progress,
                  song: current.song,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
