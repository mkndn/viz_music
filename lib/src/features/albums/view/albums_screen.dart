import 'package:flutter/material.dart';
import 'package:mkndn/src/shared/classes/classes.dart';
import 'package:mkndn/src/shared/views/brightness_toggle.dart';

import '../../../shared/views/grid_view_mixin.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen(
      {required this.content, super.key, this.axis = Axis.vertical});

  final Axis axis;
  final MediaContent content;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
          child: Scaffold(
            primary: false,
            appBar: AppBar(
              primary: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: const BrightnessToggle(),
                ),
              ],
            ),
            body: GridViewMixin(
              mediaStreamSupplier: () => content.getAlbums(),
              constraints: constraints,
            ),
          ),
        );
      },
    );
  }
}
