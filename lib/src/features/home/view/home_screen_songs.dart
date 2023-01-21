import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkndn/src/features/songs/view/song_list_mixin.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/playback/bloc/playback_bloc.dart';

class TopSongs extends StatelessWidget {
  const TopSongs({
    super.key,
    required this.content,
  });

  final MediaContent content;

  @override
  Widget build(BuildContext context) {
    final PlaybackBloc bloc = BlocProvider.of<PlaybackBloc>(context);
    return LayoutBuilder(
      builder: (context, constraints) => SongListMixin(
        queueMutator: (song) => {
          if (!listEquals(bloc.state.queue.songs, content.getTop5Songs()))
            {bloc.add(PlaybackEvent.addToQueue(song))}
        },
        songStreamSupplier: () => Stream.fromIterable(content.getTop5Songs()),
      ),
    );
  }
}

class NewReleases extends StatelessWidget {
  const NewReleases({
    super.key,
    required this.content,
  });

  final MediaContent content;

  @override
  Widget build(BuildContext context) {
    final PlaybackBloc bloc = BlocProvider.of<PlaybackBloc>(context);
    return LayoutBuilder(
      builder: (context, constraints) => SongListMixin(
        queueMutator: (song) => {
          if (!listEquals(bloc.state.queue.songs, content.recentlyAdded()))
            {bloc.add(PlaybackEvent.addToQueue(song))}
        },
        songStreamSupplier: () => Stream.fromIterable(content.recentlyAdded()),
      ),
    );
  }
}
