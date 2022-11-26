import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/classes/song_queue.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/enums/display_type.dart';
import 'package:mkndn/src/shared/enums/sort_mode.dart';
import 'package:mkndn/src/shared/enums/sorting.dart';
import 'package:mkndn/src/shared/enums/state.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/playback/bloc/playback_bloc.dart';
import 'package:mkndn/src/shared/providers/preferences.dart';
import 'package:mkndn/src/shared/splash/bloc/splash_screen.dart';
import 'package:mkndn/src/shared/splash/bloc/splash_screen_bloc.dart';
import 'package:mkndn/src/shared/views/brightness_toggle.dart';
import 'package:mkndn/src/shared/views/search.dart';

import 'song_content_mixin.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen(
      {required this.mediaContent, super.key, this.axis = Axis.horizontal});

  final MediaContent mediaContent;
  final Axis axis;

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  late List<Song> songs;
  bool stateLoaded = false;
  bool _searching = false;
  late SortMode _isSortMode;
  late DisplayType _displayType;
  late SongSortField _sortByField;
  final Preferences _prefs = Preferences();

  Future<void> initDisplayType() async {
    String? displayTypePref =
        await _prefs.getString(SongListDisplayState.display.name);
    this._displayType = DisplayType.of(displayTypePref, DisplayType.GRID);
  }

  Future<void> initSortField() async {
    String? sortedByPref =
        await _prefs.getString(SongListDisplayState.sortedBy.name);
    this._sortByField = SongSortField.of(sortedByPref, SongSortField.title);
  }

  Future<void> initSortMode() async {
    String? sortModePref =
        await _prefs.getString(SongListDisplayState.sortMode.name);
    this._isSortMode = SortMode.of(sortModePref, SortMode.ASC);
  }

  Future<void> initFromPrefs() async {
    await initDisplayType();
    await initSortField();
    await initSortMode();
  }

  @override
  void initState() {
    final SplashScreenBloc splashBloc =
        BlocProvider.of<SplashScreenBloc>(context);
    splashBloc.add(const SplashScreenEvent.showSplashScreen());
    final PlaybackBloc playbackBloc = BlocProvider.of<PlaybackBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initFromPrefs().whenComplete(() {
        this.songs = widget.mediaContent.getSongsSortedBy(_sortByField, false);
        playbackBloc.add(PlaybackEvent.initQueue(SongQueue.load(this.songs)));
        this.stateLoaded = true;
        splashBloc.add(const SplashScreenEvent.naviagteToHomeScreen());
      });
    });
    super.initState();
  }

  PopupMenuButton<DisplayType> prepareDisplayMenu() {
    return PopupMenuButton<DisplayType>(
      onSelected: (value) => setState(() {
        this._displayType = value;
        _prefs.setString(
          SongListDisplayState.display.name,
          this._displayType.text,
        );
      }),
      icon: _displayType.icon,
      iconSize: 20.0,
      position: PopupMenuPosition.under,
      color: Theme.of(context).colorScheme.onSecondary,
      itemBuilder: (context) {
        return DisplayType.values
            .map(
              (e) => PopupMenuItem(
                value: e,
                child: _displayType == e
                    ? Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Icon(Icons.check, size: 20),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(e.name),
                        ],
                      )
                    : Text(e.name),
              ),
            )
            .toList();
      },
    );
  }

  PopupMenuButton<SongSortField> prepareSortMenu() {
    return PopupMenuButton<SongSortField>(
      onSelected: (value) => setState(() {
        this._sortByField = value;
        this.songs = _isSortMode == SortMode.DESC
            ? widget.mediaContent.getSongsSortedBy(value, true)
            : widget.mediaContent.getSongsSortedBy(value, false);
        _prefs.setString(
          SongListDisplayState.sortedBy.name,
          this._sortByField.text,
        );
      }),
      icon: Icon(Icons.sort_by_alpha),
      iconSize: 20.0,
      position: PopupMenuPosition.under,
      color: Theme.of(context).colorScheme.onSecondary,
      itemBuilder: (context) {
        return SongSortField.values
            .map(
              (e) => PopupMenuItem(
                value: e,
                child: _sortByField == e
                    ? Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: [
                          Icon(Icons.check, size: 20),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Text(e.text),
                        ],
                      )
                    : Text(e.text),
              ),
            )
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SplashScreenBloc>(context);

    return BlocBuilder<SplashScreenBloc, SplashScreenState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.splashState == SplashState.load || !this.stateLoaded) {
            return SplashScreen();
          } else if (state.splashState == SplashState.close) {
            return LayoutBuilder(
              builder: (context, constraints) {
                // Add conditional mobile layout
                return loadContent();
              },
            );
          } else {
            return const Text('App is idle');
          }
        });
  }

  Widget loadContent() {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Scaffold(
          primary: false,
          appBar: AppBar(
            title: Center(
                child: SearchBar(
              isSearching: _searching,
            )),
            actions: [
              IconButton(
                icon: Icon(Icons.search, size: 20.0),
                onPressed: () => setState(() => _searching = !_searching),
              ),
              const SizedBox(
                width: 10.0,
              ),
              prepareDisplayMenu(),
              const SizedBox(
                width: 10.0,
              ),
              prepareSortMenu(),
              const SizedBox(
                width: 10.0,
              ),
              AnimatedRotation(
                turns: _isSortMode == SortMode.DESC ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: IconButton(
                  icon: Icon(Icons.keyboard_double_arrow_up, size: 20.0),
                  onPressed: () => setState(() {
                    this._isSortMode = this._isSortMode == SortMode.ASC
                        ? SortMode.DESC
                        : SortMode.ASC;
                    this.songs = _isSortMode == SortMode.DESC
                        ? widget.mediaContent
                            .getSongsSortedBy(_sortByField, true)
                        : widget.mediaContent
                            .getSongsSortedBy(_sortByField, false);
                    _prefs.setString(
                      SongListDisplayState.sortMode.name,
                      this._isSortMode.text,
                    );
                  }),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              const BrightnessToggle(),
            ],
          ),
          body: SongContentMixin(
            mediaContent: widget.mediaContent,
            songs: widget.mediaContent.songs,
            constraints: constraints,
            display: constraints.isMobile ? DisplayType.LIST : DisplayType.GRID,
          ),
        ),
      ),
    );
  }
}
