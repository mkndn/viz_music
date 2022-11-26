import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:mkndn/src/features/home/view/home_artists.dart';
import 'package:mkndn/src/features/home/view/home_highlight.dart';
import 'package:mkndn/src/features/home/view/home_recent.dart';
import 'package:mkndn/src/features/home/view/home_screen_songs.dart';
import 'package:mkndn/src/shared/classes/artist.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/typedefs.dart';
import 'package:mkndn/src/shared/views/brightness_toggle.dart';
import 'package:mkndn/src/shared/views/floating_window_options.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({required this.mediaContent, super.key});

  final MediaContent mediaContent;

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final MapOfStringList playlists = widget.mediaContent.playlists;
    final List<Artist> artists = widget.mediaContent.getTop5Artists();
    return Scaffold(
      floatingActionButton: FloatingWindowOptions(),
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
            AdaptiveContainer(
              columnSpan: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0), // Modify this line
                    child: Text(
                      'Recently played',
                      style: context.headlineSmall,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  HomeRecent(
                    playlists: playlists,
                  ),
                ],
              ),
            ),
            AdaptiveContainer(
              columnSpan: 12,
              child: Padding(
                padding: const EdgeInsets.all(15.0), // Modify this line
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.all(15.0), // Modify this line
                            child: Text(
                              'Top Songs Today',
                              style: context.titleLarge,
                            ),
                          ),
                          TopSongs(content: widget.mediaContent),
                        ],
                      ),
                    ),
                    // Add spacer between tables
                    Flexible(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.all(15.0), // Modify this line
                            child: Text(
                              'New Releases',
                              style: context.titleLarge,
                            ),
                          ),
                          NewReleases(content: widget.mediaContent),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
