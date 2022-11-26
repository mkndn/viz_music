import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/shared/typedefs.dart';

import '../../../shared/extensions.dart';
import '../../../shared/views/clickable.dart';
import '../../../shared/views/outlined_card.dart';

class HomeRecent extends StatelessWidget {
  const HomeRecent(
      {super.key, required this.playlists, this.axis = Axis.horizontal});

  final MapOfStringList playlists;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    if (axis == Axis.horizontal) {
      return SizedBox(
        height: 295,
        child: ListView.builder(
          scrollDirection: axis,
          padding: const EdgeInsets.only(left: 10),
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlistTitle = playlists.keys.elementAt(index);
            return Clickable(
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: OutlinedCard(
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                          child: buildDetails(context, playlistTitle),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () =>
                  GoRouter.of(context).go('/playlists/${playlistTitle}'),
            );
          },
        ),
      );
    }
    return Expanded(
      child: ListView.builder(
        scrollDirection: axis,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlistTitle = playlists.keys.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Clickable(
              onTap: () =>
                  GoRouter.of(context).go('/playlists/${playlistTitle}'),
              child: SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: buildDetails(context, playlistTitle),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildDetails(BuildContext context, String playlistTitle) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(
            playlistTitle,
            style: context.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
