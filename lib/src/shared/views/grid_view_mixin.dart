import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/shared/classes/media.dart';
import 'package:mkndn/src/shared/typedefs.dart';
import 'package:mkndn/src/shared/views/stream_loader.dart';

import 'image_tile.dart';

class GridViewMixin extends StatelessWidget {
  const GridViewMixin(
      {required this.mediaStreamSupplier,
      required this.constraints,
      super.key});

  final BoxConstraints constraints;
  final Supplier<Stream<Media>> mediaStreamSupplier;

  @override
  Widget build(BuildContext context) {
    return StreamLoader<Media>(
      streamSupplier: mediaStreamSupplier,
      childLoader: (items) => GridView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (constraints.maxWidth ~/ 200).toInt(),
          childAspectRatio: 0.70,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ImageTile(image: items[index].albumCover, contents: [
              items[index].title,
              items[index].composedBy ?? '',
              items[index].year as String,
            ]),
            onTap: () =>
                GoRouter.of(context).go('/albums/${items[index].title}'),
          );
        },
      ),
    );
  }
}
