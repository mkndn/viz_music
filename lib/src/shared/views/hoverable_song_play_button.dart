import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../classes/classes.dart';
import '../playback/bloc/bloc.dart';
import '../views/views.dart';

/// Renders the child widget when not hovered and a Play button when hovered.
class HoverableSongPlayButton extends StatelessWidget {
  const HoverableSongPlayButton({
    super.key,
    required this.song,
    required this.index,
    required this.child,
    this.size = const Size(50, 50),
    this.hoverMode = HoverMode.replace,
  });

  final Widget child;
  final Size size;
  final Song song;
  final int index;
  final HoverMode hoverMode;

  @override
  Widget build(BuildContext context) {
    final PlaybackBloc bloc = BlocProvider.of<PlaybackBloc>(context);
    return HoverToggle(
      hoverChild: Center(
        child: GestureDetector(
          child: const Icon(Icons.play_arrow),
          onTap: () => bloc.add(
            PlaybackEvent.changeSong(index),
          ),
        ),
      ),
      mode: hoverMode,
      size: size,
      child: child,
    );
  }
}
