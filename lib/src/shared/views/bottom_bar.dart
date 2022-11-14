import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myartist/src/shared/classes/media_content.dart';
import 'package:myartist/src/shared/enums/repeat_mode.dart';
import 'package:myartist/src/shared/state/inmemory_media_manager.dart';
import 'package:myartist/src/shared/typedefs.dart';
import 'package:myartist/src/shared/views/bottom_bar_song_overlay.dart';

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
          songWithProgress: state.songWithProgress,
          isMuted: state.isMuted,
          isPlaying: state.isPlaying,
          isFullPlayerOn: state.isFullPlayerOn,
          repeatMode: state.repeatMode,
          preferredSize: preferredSize,
          currentIndex: state.currentIndex,
          upperLimit: state.queue.length,
          queue: state.queue,
          durationStreamSupplier: bloc.currentlyPlayingSubscription.onData((data) { }),
          togglePlayPause: () => bloc.add(
            const PlaybackEvent.togglePlayPause(),
          ),
          changeSong: (int index) {
            bloc.add(PlaybackEvent.changeSong(index));
          },
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
    required this.songWithProgress,
    required this.isMuted,
    required this.isPlaying,
    required this.isFullPlayerOn,
    required this.repeatMode,
    required this.preferredSize,
    required this.queue,
    required this.togglePlayPause,
    required this.toggleFullPlayer,
    required this.changeRepeatMode,
    required this.changeSong,
    required this.currentIndex,
    required this.upperLimit,
    required this.volume,
    required this.durationStreamSupplier,
  });

  final InMemoryMediaManagerState mediaManagerState;
  final SongWithProgress? songWithProgress;
  final bool isMuted;
  final bool isPlaying;
  final bool isFullPlayerOn;
  final RepeatMode repeatMode;
  final Size preferredSize;
  final List<Song> queue;
  final VoidCallback togglePlayPause;
  final VoidCallback toggleFullPlayer;
  final VoidCallback changeRepeatMode;
  final Consumer<int> changeSong;
  final int currentIndex;
  final int upperLimit;
  final double volume;
  final Supplier<Stream<Duration>> durationStreamSupplier;

  @override
  State<_BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<_BottomBar> {
  String? _artist;
  Duration? _progress;
  Song? _song;
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
        widget.mediaManagerState.rankMedia(widget.songWithProgress!.song.id);
        await _rankMediaStreamSubscription!.cancel();
      }
    }
  }

  void triggerChangeSong(int triggerSongIndex) {
    if (this._rankMediaStreamSubscription == null) {
      this._rankMediaStreamSubscription = widget.durationStreamSupplier().listen(
          (value) async => await handleRankMedia(value)
              .whenComplete(() => this._rankMediaStreamSubscription = null));
    }
    widget.changeSong(triggerSongIndex);
  }

  void triggerPlayPause() async {
    if (this._rankMediaStreamSubscription == null) {
      this._rankMediaStreamSubscription = widget.durationStreamSupplier().listen(
          (value) async => await handleRankMedia(value)
              .whenComplete(() => this._rankMediaStreamSubscription = null));
    }
    widget.togglePlayPause();
  }

  void _buildSonglistOverlay(BuildContext context, List<Song> queue,
      Size parentSize, int currentIndex) {
    this._songlistOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
            left: 200,
            child: BottomBarSongOverlay(
              parentSize: parentSize,
              queue: queue,
              currentSong: queue[currentIndex],
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
    _artist = widget.songWithProgress?.song.artist;
    _progress = widget.songWithProgress?.progress;
    _song = widget.songWithProgress?.song;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this._overlayState = Overlay.of(context);
      _buildSonglistOverlay(
          context, widget.queue, widget.preferredSize, widget.currentIndex);
      if (widget.isFullPlayerOn) buildFullScreenPlayerOverlay(context);
    });
  }

  @override
  void dispose() {
    if (this._fullScreenPlayerOverlay != null) {
      this._fullScreenPlayerOverlay!.remove();
      this._fullScreenPlayerOverlay = null;
    }
    if (this._overlayState != null) {
      this._overlayState!.dispose();
      this._overlayState = null;
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
                _AlbumArt(song: _song),
                _SongDetails(
                  artist:
                      _artist != null ? _info.getArtistById(_artist!) : null,
                  song: _song,
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
                    togglePlayPause: triggerPlayPause,
                    changeRepeatMode: widget.changeRepeatMode,
                    changeSong: triggerChangeSong,
                    currentIndex: widget.currentIndex,
                    upperLimit: widget.upperLimit,
                    repeatMode: widget.repeatMode,
                    songlistValue: _isSonglistLoaded,
                    renderSonglist: _renderSonglistOverlay,
                  ),
                  Center(
                    child: _ProgressBar(
                      progress: _progress,
                      song: _song,
                    ),
                  ),
                ],
              ),
            ),
            if (constraints.isDesktop) ...[
              _VolumeBar(volume: widget.volume, isMuted: widget.isMuted),
            ],
            if (_song != null)
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

  double get songProgress => _progress != null && _song != null
      ? _progress!.inMilliseconds / _song!.length.inMilliseconds
      : 0;

  Widget _buildMobileBar(BuildContext context, BoxConstraints constraints) {
    final Artist? artist =
        _song?.artist != null ? _info.getArtistById(_song!.artist) : null;
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
                    _AlbumArt(song: _song),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _song?.title ?? '',
                          style: context.labelMedium,
                        ),
                        Text(
                          artist?.name ?? '',
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
    required this.changeSong,
    required this.currentIndex,
    required this.upperLimit,
    required this.repeatMode,
    required this.renderSonglist,
    required this.songlistValue,
  }) : super(key: key);

  final bool isPlaying;
  final VoidCallback togglePlayPause;
  final VoidCallback changeRepeatMode;
  final Consumer<int> changeSong;
  final int currentIndex;
  final int upperLimit;
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
            onPressed: () =>
                (currentIndex - 1 >= 0) ? changeSong(currentIndex - 1) : {},
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
            onPressed: () => (currentIndex + 1 < upperLimit)
                ? changeSong(currentIndex + 1)
                : {},
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
            ? Image.memory(song!.image)
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
              artist != null ? artist!.name : '-',
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
    final current = state.songWithProgress;
    final song = current?.song;
    final currentIndex = state.currentIndex;
    final upperLimit = state.queue.length;
    final repeatMode = state.repeatMode;
    final Artist? artist =
        song?.artist != null ? widget.info.getArtistById(song!.artist) : null;
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
                      song!.image,
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
                  child: ClippedImage(song.image),
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
                      artist?.name ?? '',
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
                  changeSong: (index) =>
                      bloc.add(PlaybackEvent.changeSong(index)),
                  changeRepeatMode: () =>
                      bloc.add(const PlaybackEvent.changeRepeatMode()),
                  currentIndex: currentIndex,
                  upperLimit: upperLimit,
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
    final current = state.songWithProgress;
    final currentIndex = state.currentIndex;
    final upperLimit = state.queue.length;
    final repeatMode = state.repeatMode;
    final Artist? artist = current?.song.artist != null
        ? info.getArtistById(current!.song.artist)
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
                      current.song.image,
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
                current.song.image,
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
                        artist?.name ?? '',
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
                      changeSong: (int index) =>
                          bloc.add(PlaybackEvent.changeSong(index)),
                      changeRepeatMode: () =>
                          bloc.add(const PlaybackEvent.changeRepeatMode()),
                      currentIndex: currentIndex,
                      upperLimit: upperLimit,
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
