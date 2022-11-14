import 'package:flutter/material.dart';
import 'package:myartist/src/features/songs/view/song_list_mixin.dart';
import 'package:myartist/src/shared/models/song.dart';

class BottomBarSongOverlay extends StatelessWidget {
  const BottomBarSongOverlay(
      {required this.parentSize,
      required this.queue,
      required this.currentSong,
      super.key});

  final Size parentSize;
  final List<Song> queue;
  final Song? currentSong;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - parentSize.height,
      width: MediaQuery.of(context).size.width - 200,
      color: Theme.of(context).colorScheme.background,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            child: Scaffold(
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: SongListMixin(songs: queue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
