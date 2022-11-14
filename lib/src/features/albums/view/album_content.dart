import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';

import '../../../shared/classes/album.dart';
import '../../../shared/extensions.dart';

class AlbumContent extends StatefulWidget {
  const AlbumContent({required this.album, super.key});

  final Album album;

  @override
  State<AlbumContent> createState() => _AlbumContentState();
}

class _AlbumContentState extends State<AlbumContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: AdaptiveContainer(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  image:
                      DecorationImage(image: MemoryImage(widget.album.image)),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.album.title,
                  style: context.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.album.albumArtist ?? '',
                  style: context.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.album.year ?? '',
                  style: context.labelMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
