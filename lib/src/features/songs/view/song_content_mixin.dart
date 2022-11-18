import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/classes/song_queue.dart';
import 'package:mkndn/src/shared/models/song.dart';
import 'package:mkndn/src/shared/enums/display_type.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/playback/bloc/playback_bloc.dart';
import 'package:mkndn/src/shared/views/image_tile.dart';
import 'package:objectid/objectid.dart';

class SongContentMixin extends StatefulWidget {
  const SongContentMixin({
    required this.mediaContent,
    required this.queue,
    required this.display,
    required this.constraints,
    this.axis = Axis.vertical,
    super.key,
  });

  final MediaContent mediaContent;
  final Axis axis;
  final SongQueue queue;
  final BoxConstraints constraints;
  final DisplayType display;

  @override
  State<SongContentMixin> createState() => _SongContentMixinState();
}

class _SongContentMixinState extends State<SongContentMixin> {
  PlaybackEvent getEvent(ObjectId songId, bool queueInitiated) {
    return queueInitiated
        ? PlaybackEvent.changeSong(widget.queue.getSongById(songId))
        : PlaybackEvent.initQueue(widget.queue);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.display == DisplayType.LIST) {
      return buildListLayout(BlocProvider.of<PlaybackBloc>(context));
    }
    return buildGridLayout(BlocProvider.of<PlaybackBloc>(context));
  }

  Widget buildGridLayout(PlaybackBloc bloc) {
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
      itemCount: widget.queue.songs.length,
      itemBuilder: (context, index) {
        Song song = widget.queue.songs[index];
        return GestureDetector(
          onTap: () => bloc.add(getEvent(
              widget.queue.songs[index].id, bloc.state.queue.isNotEmpty)),
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

  Widget buildListLayout(PlaybackBloc bloc) {
    return ListView.builder(
      scrollDirection: widget.axis,
      shrinkWrap: true,
      padding: const EdgeInsets.all(15),
      itemCount: widget.queue.songs.length,
      itemBuilder: (context, index) {
        Song song = widget.queue.songs[index];
        return GestureDetector(
          onTap: () => bloc.add(getEvent(
              widget.queue.songs[index].id, bloc.state.queue.isNotEmpty)),
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
