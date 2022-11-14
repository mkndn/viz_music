import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

mixin MediaUtilMixin {
  String combineValues(List<String>? stringList) {
    return stringList != null ? stringList.join(",") : '';
  }

  Future<ui.Image?> bytesToImage(Uint8List? imgBytes) async {
    if (imgBytes == null) {
      return null;
    }
    ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }
}
