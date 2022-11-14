import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myartist/src/shared/mixins/utils.dart';

enum RepeatMode {
  noRepeat(0, Icon(Icons.repeat)),
  repeatCurrent(1, Icon(Icons.repeat_one)),
  repeatQueue(
      2,
      Icon(
        Icons.repeat_on,
        size: 18,
      ));

  final int idx;
  final Icon icon;

  const RepeatMode(this.idx, this.icon);

  static RepeatMode of(String? text, RepeatMode defaultValue) => text != null
      ? Utils.defautIfNull(
          () => RepeatMode.values
              .firstWhereOrNull((element) => element.name == text),
          defaultValue)
      : defaultValue;

  RepeatMode nextById() {
    int nextId = this.idx + 1 == RepeatMode.values.length ? 0 : this.idx + 1;
    return Utils.defautIfNull(
        () => RepeatMode.values
            .firstWhereOrNull((element) => element.idx == nextId),
        RepeatMode.noRepeat);
  }
}
