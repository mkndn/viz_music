import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/enums/display_type.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/playback/bloc/playback_bloc.dart';
import 'package:mkndn/src/shared/typedefs.dart';
import 'package:mkndn/src/shared/views/image_tile.dart';
import 'package:mkndn/src/shared/views/stream_loader.dart';

class SongContentMixin extends StatelessWidget {
  const SongContentMixin({
    required this.songStreamSupplier,
    required this.display,
    required this.constraints,
    this.axis = Axis.vertical,
    super.key,
  });

  final Supplier<Stream<Song>> songStreamSupplier;
  final Axis axis;
  final BoxConstraints constraints;
  final DisplayType display;

  @override
  Widget build(BuildContext context) {
    if (display == DisplayType.LIST) {
      return buildListLayout(BlocProvider.of<PlaybackBloc>(context));
    }
    return buildGridLayout(BlocProvider.of<PlaybackBloc>(context));
  }

  Widget buildGridLayout(PlaybackBloc bloc) {
    return StreamLoader<Song>(
      streamSupplier: songStreamSupplier,
      childLoader: (items) => GridView.builder(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(15.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (constraints.maxWidth ~/ 200).toInt(),
          childAspectRatio: 0.70,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          Song song = items[index];
          return GestureDetector(
            onTap: () => bloc.add(PlaybackEvent.changeSong(song.title)),
            child: ImageTile(
              image: song.albumCover,
              contents: [
                song.title,
                song.album,
                song.length.toHumanizedString(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildListLayout(PlaybackBloc bloc) {
    return StreamLoader<Song>(
        streamSupplier: songStreamSupplier,
        childLoader: (items) => ListView.builder(
              scrollDirection: axis,
              shrinkWrap: true,
              padding: const EdgeInsets.all(15),
              itemCount: items.length,
              itemBuilder: (context, index) {
                Song song = items[index];
                return GestureDetector(
                  onTap: () => bloc.add(PlaybackEvent.changeSong(song.title)),
                  child: ImageTile(
                    image: song.albumCover,
                    contents: [
                      song.title,
                      song.album,
                      song.length.toHumanizedString(),
                    ],
                  ),
                );
              },
            ));
  }
}
