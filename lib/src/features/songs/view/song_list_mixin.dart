import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/shared/classes/song_queue.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/models/song.dart';
import 'package:objectid/objectid.dart';
import '../../../shared/playback/bloc/bloc.dart';
import '../../../shared/views/image_clipper.dart';
import '../../../shared/views/views.dart';

class SongListMixin extends StatelessWidget {
  const SongListMixin({super.key, required this.queue});

  final SongQueue queue;

  PlaybackEvent getEvent(ObjectId songId, bool queueInitiated) {
    return queueInitiated
        ? PlaybackEvent.changeSong(queue.getSongById(songId))
        : PlaybackEvent.initQueue(queue);
  }

  @override
  Widget build(BuildContext context) {
    final PlaybackBloc bloc = BlocProvider.of<PlaybackBloc>(context);
    return AdaptiveTable<Song>(
      items: queue.songs,
      breakpoint: 450,
      columns: const [
        DataColumn(
          label: Expanded(
            child: Text(
              '#',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataColumn(
          label: Text('Title'),
        ),
        DataColumn(
          label: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text('Length'),
          ),
        ),
      ],
      rowBuilder: (context, index) => DataRow.byIndex(
        index: index,
        cells: [
          DataCell(
            Center(
              child: HoverableSongPlayButton(
                hoverMode: HoverMode.overlay,
                song: queue.songs[index],
                index: index,
                action: () => bloc.add(getEvent(
                    queue.songs[index].id, bloc.state.queue.isNotEmpty)),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          DataCell(
            Row(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                child: ClippedImage(queue.songs[index].image),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(queue.songs[index].title)),
            ]),
          ),
          DataCell(
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(queue.songs[index].length.toHumanizedString()),
            ),
          ),
        ],
      ),
      itemBuilder: (song, index) {
        return ListTile(
          onTap: () => bloc.add(getEvent(song.id, bloc.state.queue.isNotEmpty)),
          leading: ClippedImage(song.image),
          title: Text(song.title),
          subtitle: Text(song.length.toHumanizedString()),
        );
      },
    );
  }
}
