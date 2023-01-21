import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/shared/classes/artist.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/views/brightness_toggle.dart';
import '../../../shared/views/grid_view_mixin.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({required this.info, required this.name, super.key});

  final MediaContent info;
  final String name;

  @override
  Widget build(BuildContext context) {
    Artist? artist = info.getArtistByTitle(name);
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
                  '${artist?.title}',
                  style: context.displaySmall,
                ),
              ),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: (artist == null)
                  ? const Text('No content')
                  : GridViewMixin(
                      mediaStreamSupplier: () => info.getArtistAlbums(
                        artist.title,
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
