import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/album.dart';
import 'image_tile.dart';

class GridViewMixin extends StatelessWidget {
  const GridViewMixin(
      {required this.albums, required this.constraints, super.key});

  final BoxConstraints constraints;
  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (constraints.maxWidth ~/ 200).toInt(),
        childAspectRatio: 0.70,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        Album album = albums[index];
        return GestureDetector(
          child: ImageTile(image: album.image, contents: [
            album.title,
            album.albumArtist ?? '',
            album.year ?? ''
          ]),
          onTap: () => GoRouter.of(context).go('/albums/${album.id}'),
        );
      },
    );
  }
}
