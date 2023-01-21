import 'package:flutter/material.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/classes/text_tile_content.dart';
import 'package:mkndn/src/shared/views/brightness_toggle.dart';
import 'package:mkndn/src/shared/views/text_tile_mixin.dart';

class ArtistList extends StatelessWidget {
  const ArtistList({required this.mediaContent, super.key});

  final MediaContent mediaContent;

  @override
  Widget build(BuildContext context) {
    final List<TextTileContent> contents = mediaContent.artists
        .map((e) => TextTileContent(value: e.title, ref: e.title))
        .toList();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Scaffold(
            primary: false,
            appBar: AppBar(
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
              redirectPrefix: '/artists',
            ),
          ),
        );
      },
    );
  }
}
