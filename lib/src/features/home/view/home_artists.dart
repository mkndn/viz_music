import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/shared/models/artist.dart';

import '../../../shared/extensions.dart';

class HomeArtists extends StatelessWidget {
  const HomeArtists({
    super.key,
    required this.artists,
    required this.constraints,
  });

  final List<Artist> artists;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: constraints.isMobile
          ? Column(
              children: [
                for (final artist in artists) buildTile(context, artist),
              ],
            )
          : Row(children: [
              for (final artist in artists)
                Flexible(
                  flex: 1,
                  child: buildTile(context, artist),
                ),
            ]),
    );
  }

  Widget buildTile(BuildContext context, Artist artist) {
    return ListTile(
      title: Text(
        artist.name,
        maxLines: 2,
        style: context.labelLarge,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => GoRouter.of(context).go('/artists/${artist.id}'),
    );
  }
}
