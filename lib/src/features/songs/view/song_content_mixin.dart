import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myartist/src/shared/classes/media_content.dart';
import 'package:myartist/src/shared/state/player_state.dart';
import 'package:myartist/src/shared/classes/song.dart';
import 'package:myartist/src/shared/enums/display_type.dart';
import 'package:myartist/src/shared/extensions.dart';
import 'package:myartist/src/shared/playback/bloc/playback_bloc.dart';
import 'package:myartist/src/shared/typedefs.dart';
import 'package:myartist/src/shared/views/image_tile.dart';

class SongContentMixin extends StatefulWidget {
  const SongContentMixin({
    required this.mediaContent,
    required this.songs,
    required this.display,
    required this.constraints,
    this.axis = Axis.vertical,
    super.key,
  });

  final MediaContent mediaContent;
  final Axis axis;
  final List<Song> songs;
  final BoxConstraints constraints;
  final DisplayType display;

  @override
  State<SongContentMixin> createState() => _SongContentMixinState();
}

class _SongContentMixinState extends State<SongContentMixin> {
  bool _queueInitiated = false;

  PlaybackEvent getEvent(int index) {
    return _queueInitiated
        ? PlaybackEvent.changeSong(index)
        : PlaybackEvent.initQueue(widget.songs, index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.display == DisplayType.LIST) {
      return buildListLayout(() => BlocProvider.of<PlaybackBloc>(context));
    }
    return buildGridLayout(() => BlocProvider.of<PlaybackBloc>(context));
  }

  Widget buildGridLayout(Supplier<Bloc> blocSupplier) {
    return GridView.builder(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(15.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (widget.constraints.maxWidth ~/ 200).toInt(),
        childAspectRatio: 0.70,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: widget.songs.length,
      itemBuilder: (context, index) {
        Song song = widget.songs[index];
        return GestureDetector(
          onTap: () => blocSupplier().add(getEvent(index)),
          child: ImageTile(
            image: song.image,
            contents: [
              song.title,
              widget.mediaContent.getAlbumById(song.album)?.title ?? '',
              song.length.toHumanizedString(),
            ],
          ),
        );
      },
    );
  }

  Widget buildListLayout(Supplier<Bloc> blocSupplier) {
    return ListView.builder(
      scrollDirection: widget.axis,
      shrinkWrap: true,
      padding: const EdgeInsets.all(15),
      itemCount: widget.songs.length,
      itemBuilder: (context, index) {
        Song song = widget.songs[index];
        return GestureDetector(
          onTap: () => blocSupplier().add(getEvent(index)),
          child: ImageTile(
            image: song.image,
            contents: [
              song.title,
              widget.mediaContent.getAlbumById(song.album)?.title ?? '',
              song.length.toHumanizedString(),
            ],
          ),
        );
      },
    );
  }
}
