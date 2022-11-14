import 'package:flutter/material.dart';
import 'package:myartist/src/shared/models/playlist.dart';
import 'package:myartist/src/shared/classes/text_tile_content.dart';
import 'package:myartist/src/shared/views/brightness_toggle.dart';
import 'package:myartist/src/shared/views/text_tile_mixin.dart';

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({required this.playlists, super.key});

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    List<TextTileContent> contents = playlists
        .map((e) => TextTileContent(value: e.title, ref: e.id))
        .toList();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Scaffold(
              primary: false,
              appBar: AppBar(
                primary: false,
                excludeHeaderSemantics: false,
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
              body: TextTileMixin(
                contents: contents,
                constraints: constraints,
                redirectPrefix: '/playlists',
              )),
        );
      },
    );
  }
}
