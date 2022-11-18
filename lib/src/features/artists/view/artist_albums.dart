import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/views/brightness_toggle.dart';
import 'package:objectid/objectid.dart';

import '../../../shared/models/artist.dart';
import '../../../shared/views/grid_view_mixin.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({required this.info, required this.id, super.key});

  final MediaContent info;
  final String id;

  @override
  Widget build(BuildContext context) {
    Artist? artist = info.getArtistById(ObjectId.fromHexString(id));
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: const BrightnessToggle(),
                ),
              ],
              leading: BackButton(
                onPressed: () => GoRouter.of(context).go('/artists'),
              ),
              title: Expanded(
                child: Text(
                  '${artist?.name}',
                  style: context.displaySmall,
                ),
              ),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: (artist == null)
                  ? const Text('No content')
                  : GridViewMixin(
                      albums: info.getAlbumsById(
                        artist.albums,
                      ),
                      constraints: constraints,
                    ),
            ),
          ),
        );
      },
    );
  }
}
