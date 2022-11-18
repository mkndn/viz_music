import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mkndn/src/shared/classes/text_tile_content.dart';
import 'package:mkndn/src/shared/enums/display_type.dart';
import 'package:mkndn/src/shared/views/outlined_card.dart';
import '../extensions.dart';

class TextTileMixin extends StatelessWidget {
  const TextTileMixin({
    required this.contents,
    required this.constraints,
    this.displayType = DisplayType.GRID,
    this.redirectPrefix,
    super.key,
    this.axis = Axis.vertical,
  });

  final Axis axis;
  final BoxConstraints constraints;
  final List<TextTileContent> contents;
  final String? redirectPrefix;
  final DisplayType displayType;

  @override
  Widget build(BuildContext context) {
    return (displayType == DisplayType.LIST)
        ? listViewBuilder()
        : gridViewBuilder(constraints);
  }

  Widget listViewBuilder() {
    return ListView.builder(
      scrollDirection: axis,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      itemCount: contents.length,
      itemBuilder: (context, index) {
        final TextTileContent content = contents[index];
        return Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                child: OutlinedCard(
                  clickable: true,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(content.value),
                  ),
                ),
                onTap: () => content.ref != null && redirectPrefix != null
                    ? GoRouter.of(context)
                        .go('$redirectPrefix/${content.ref!.hexString}')
                    : {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget gridViewBuilder(BoxConstraints constraints) {
    return GridView.builder(
      scrollDirection: axis,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220.0,
          childAspectRatio: 0.90,
          mainAxisSpacing: 2,
          crossAxisSpacing: 5,
          mainAxisExtent: 100.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      itemCount: contents.length,
      itemBuilder: (context, index) {
        final TextTileContent content = contents[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: OutlinedCard(
              lightColor: Theme.of(context).colorScheme.inversePrimary,
              darkColor: Theme.of(context).colorScheme.inversePrimary,
              clickable: true,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    content.value,
                    overflow: TextOverflow.visible,
                    style: context.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            onTap: () => content.ref != null && redirectPrefix != null
                ? GoRouter.of(context).go('$redirectPrefix/${content.ref}')
                : {},
          ),
        );
      },
    );
  }
}
