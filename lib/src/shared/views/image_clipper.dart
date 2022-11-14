import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClippedImage extends StatelessWidget {
  const ClippedImage(
    this.image, {
    this.fit,
    this.height,
    this.width,
    super.key,
  });

  final Uint8List image;
  final BoxFit? fit;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(
        image,
        fit: fit ?? BoxFit.cover,
        height: height,
        width: width,
      ),
    );
  }
}
