import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../extensions.dart';
import 'outlined_card.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.image,
    required this.contents,
  });

  final Uint8List image;
  final List<String> contents;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Image.memory(image, fit: BoxFit.cover),
              ),
            ],
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: contents
                  .map(
                    (content) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          content,
                          textAlign: TextAlign.center,
                          style: context.labelMedium!.copyWith(
                            fontWeight: FontWeight.w200,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
