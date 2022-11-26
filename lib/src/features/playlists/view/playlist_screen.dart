import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/features/songs/view/song_list_mixin.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/playback/bloc/playback_bloc.dart';
import 'package:mkndn/src/shared/views/brightness_toggle.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen(
      {required this.mediaContent, required this.title, super.key});

  final MediaContent mediaContent;
  final String title;

  @override
  Widget build(BuildContext context) {
    final PlaybackBloc bloc = BlocProvider.of<PlaybackBloc>(context);

    void updateQueue(Song song) {
      bloc.add(PlaybackEvent.addToQueue(song));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Scaffold(
            primary: false,
            appBar: AppBar(
              primary: false,
              title: Expanded(
                child: Text(
                  '${title}',
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
                          queueMutation: updateQueue,
                          songStreamSupplier: () =>
                              mediaContent.getPlaylistSongs(title)),
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
