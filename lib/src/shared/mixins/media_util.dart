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

  Stream<U> groupByAndStreamWithPersist<T, U>(
      Supplier<Map<String, List<T>>> groupBySupplier,
      Func<List<T>, U> prepareFunc,
      Consumer<U> persistFunc) async* {
    groupBySupplier().entries.forEach((entry) async* {
      U result = prepareFunc(entry.value);
      persistFunc(result);
      yield result;
    });
  }

  Stream<U> groupByAndStreamWithFilter<T, U>(
      Supplier<List<T>> filterFunc,
      Func<List<T>, Map<String, List<T>>> groupBySupplier,
      BiFunc<String, List<T>, U> prepareFunc) async* {
    groupBySupplier(filterFunc()).entries.forEach((entry) async* {
      yield prepareFunc(entry.key, entry.value);
    });
  }
}
