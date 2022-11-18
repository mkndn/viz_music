import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:mkndn/src/shared/typedefs.dart';

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

  int indexWhereOrDefault(Supplier<int> indexSupplier, int defaultValue) {
    int index = indexSupplier();
    return index < 0 ? defaultValue : index;
  }

  V valueOrDefault<V>(Supplier<V?> valueSupplier, V defaultValue) {
    V? value = valueSupplier();
    return value != null ? value : defaultValue;
  }
}
