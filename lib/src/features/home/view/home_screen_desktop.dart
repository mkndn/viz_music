import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:myartist/src/features/home/view/home_artists.dart';
import 'package:myartist/src/features/home/view/home_highlight.dart';
import 'package:myartist/src/shared/classes/media_content.dart';
import 'package:myartist/src/shared/extensions.dart';
import 'package:myartist/src/shared/models/artist.dart';
import 'package:myartist/src/shared/models/playlist.dart';
import 'package:myartist/src/shared/models/song.dart';
import 'package:myartist/src/shared/views/brightness_toggle.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({required this.mediaContent, super.key});

  final MediaContent mediaContent;

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Playlist> playlists = widget.mediaContent.playlists;
    final List<Song> topSongs = widget.mediaContent.getTop5Songs();
    final List<Song> newReleases = widget.mediaContent.recentlyAdded();
    final List<Artist> artists = widget.mediaContent.getTop5Artists();
    return Scaffold(
      body: SingleChildScrollView(
        child: AdaptiveColumn(
          children: [
            AdaptiveContainer(
              columnSpan: 12,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    20, 25, 20, 10), // Modify this line
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Good morning',
                        style: context.displaySmall,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const BrightnessToggle(),
                  ],
                ),
              ),
            ),
            AdaptiveContainer(
              columnSpan: 12,
              child: Column(
                children: [
                  const HomeHighlight(),
                  LayoutBuilder(
                    builder: (context, constraints) => HomeArtists(
                      artists: artists,
                      constraints: constraints,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
