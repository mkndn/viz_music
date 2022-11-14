import 'package:flutter/material.dart';
import 'package:myartist/src/features/home/view/home_artists.dart';
import 'package:myartist/src/features/home/view/home_highlight.dart';
import 'package:myartist/src/features/home/view/home_recent.dart';
import 'package:myartist/src/features/songs/view/song_content_mixin.dart';
import 'package:myartist/src/shared/classes/artist.dart';
import 'package:myartist/src/shared/classes/media_content.dart';
import 'package:myartist/src/shared/enums/display_type.dart';
import 'package:myartist/src/shared/classes/playlist.dart';
import 'package:myartist/src/shared/views/brightness_toggle.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({required this.mediaContent, super.key});

  final MediaContent mediaContent;

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Playlist> playlists = widget.mediaContent.playlists;
    final Playlist topSongs = widget.mediaContent.playlists.first;
    final Playlist newReleases = widget.mediaContent.playlists.last;
    final List<Artist> artists = widget.mediaContent.artists;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Good Morning'),
          actions: const [BrightnessToggle()],
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Home',
            ),
            Tab(
              text: 'Recently Played',
            ),
            Tab(
              text: 'New Releases',
            ),
            Tab(
              text: 'Top Songs',
            )
          ]),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const HomeHighlight(),
                    HomeArtists(
                      artists: artists,
                      constraints: constraints,
                    ),
                  ],
                ),
              ),
              HomeRecent(
                playlists: playlists,
                axis: Axis.vertical,
              ),
              SongContentMixin(
                mediaContent: widget.mediaContent,
                songs: widget.mediaContent.getSongsById(
                  topSongs.songs,
                ),
                constraints: constraints,
                display: DisplayType.GRID,
              ),
              SongContentMixin(
                mediaContent: widget.mediaContent,
                songs: widget.mediaContent.getSongsById(
                  newReleases.songs,
                ),
                display: DisplayType.GRID,
                constraints: constraints,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
