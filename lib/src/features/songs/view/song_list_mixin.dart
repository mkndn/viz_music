import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/typedefs.dart';
import 'package:mkndn/src/shared/views/stream_loader.dart';
import '../../../shared/playback/bloc/bloc.dart';
import '../../../shared/views/image_clipper.dart';
import '../../../shared/views/views.dart';

class SongListMixin extends StatelessWidget {
  const SongListMixin(
      {required this.songStreamSupplier,
      required this.queueMutation,
      super.key});

  final Consumer<Song> queueMutation;
  final Supplier<Stream<Song>> songStreamSupplier;

  @override
  Widget build(BuildContext context) {
    final PlaybackBloc bloc = BlocProvider.of<PlaybackBloc>(context);
    return StreamLoader<Song>(
      streamSupplier: songStreamSupplier,
      childLoader: (items) => AdaptiveTable<Song>(
        items: items,
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
                  action: () {
                    queueMutation(context);
                    bloc.add(
                      PlaybackEvent.changeSong(context.title),
                    );
                  },
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
                  child: ClippedImage(context.albumCover),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(context.title)),
              ]),
            ),
            DataCell(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(context.length.toHumanizedString()),
              ),
            ),
          ],
        ),
        itemBuilder: (song, index) {
          return ListTile(
            onTap: () => bloc.add(PlaybackEvent.nextInQueue()),
            leading: ClippedImage(song.albumCover),
            title: Text(song.title),
            subtitle: Text(song.length.toHumanizedString()),
          );
        },
      ),
    );
  }
}
