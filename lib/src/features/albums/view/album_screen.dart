import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:mkndn/src/features/songs/view/song_list_mixin.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/classes/song_queue.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/views/brightness_toggle.dart';
import 'package:mkndn/src/shared/views/image_tile.dart';
import 'package:objectid/objectid.dart';

import '../../../shared/models/album.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({required this.info, required this.id, super.key});

  final MediaContent info;
  final String id;

  @override
  Widget build(BuildContext context) {
    Album? album = info.getAlbumById(ObjectId.fromHexString(id));
    return LayoutBuilder(
      builder: (context, constraints) {
        if (album == null) {
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
              title: Text(
                '${album.title}',
                style: context.displaySmall,
              ),
              actions: [
                const Padding(
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
                  columnSpan: 2,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ImageTile(
                          image: album.image,
                          contents: [album.albumArtist ?? '', album.year ?? ''],
                        ),
                      ),
                    ],
                  ),
                ),
                AdaptiveContainer(
                  columnSpan: 12,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: SongListMixin(
                      queue:
                          SongQueue.load(info.getSongsById(album.songsInAlbum)),
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
