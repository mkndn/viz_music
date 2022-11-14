import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/classes/classes.dart';
import '../../../shared/extensions.dart';
import '../../../shared/playback/bloc/bloc.dart';
import '../../../shared/views/image_clipper.dart';
import '../../../shared/views/views.dart';

class SongListMixin extends StatelessWidget {
  const SongListMixin({super.key, required this.songs});

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTable<Song>(
      items: songs,
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
                song: songs[index],
                index: index,
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
                child: ClippedImage(songs[index].image),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(songs[index].title)),
            ]),
          ),
          DataCell(
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(songs[index].length.toHumanizedString()),
            ),
          ),
        ],
      ),
      itemBuilder: (song, index) {
        return ListTile(
          onTap: () => BlocProvider.of<PlaybackBloc>(context).add(
            PlaybackEvent.changeSong(index),
          ),
          leading: ClippedImage(song.image),
          title: Text(song.title),
          subtitle: Text(song.length.toHumanizedString()),
        );
      },
    );
  }
}
