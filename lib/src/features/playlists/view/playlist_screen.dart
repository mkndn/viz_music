import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:myartist/src/features/songs/view/song_list_mixin.dart';
import 'package:myartist/src/shared/classes/media_content.dart';
import 'package:myartist/src/shared/classes/playlist.dart';
import 'package:myartist/src/shared/extensions.dart';
import 'package:myartist/src/shared/views/brightness_toggle.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen(
      {required this.mediaContent, required this.id, super.key});

  final MediaContent mediaContent;
  final String id;

  @override
  Widget build(BuildContext context) {
    Playlist? playlist = mediaContent.getPlaylistById(id);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (playlist == null) {
          return AdaptiveColumn(
            children: [
              AdaptiveContainer(
                columnSpan: 12,
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('No album info available'),
                  ],
                ),
              ),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Scaffold(
            primary: false,
            appBar: AppBar(
              primary: false,
              title: Expanded(
                child: Text(
                  '${playlist.title}',
                  style: context.displaySmall,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: const BrightnessToggle(),
                ),
              ],
            ),
            body: AdaptiveColumn(
              children: [
                AdaptiveContainer(
                  columnSpan: 12,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SongListMixin(
                        songs: mediaContent.getSongsById(playlist.songs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}