import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myartist/src/shared/mixins/utils.dart';

enum DisplayType {
  LIST('List', Icon(Icons.list)),
  GRID('Grid', Icon(Icons.grid_view));

  final String text;
  final Icon icon;

  const DisplayType(this.text, this.icon);

  static DisplayType of(String? text, DisplayType defaultValue) => text != null
      ? Utils.defautIfNull(
          () => DisplayType.values
              .firstWhereOrNull((element) => element.text == text),
          defaultValue)
      : defaultValue;
}
