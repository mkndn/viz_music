import 'package:collection/collection.dart';
import 'package:myartist/src/shared/mixins/utils.dart';

enum SortMode {
  ASC('Ascending'),
  DESC('Descending');

  final String text;

  const SortMode(this.text);

  static SortMode of(String? text, SortMode defaultValue) => text != null
      ? Utils.defautIfNull(
          () => SortMode.values
              .firstWhereOrNull((element) => element.text == text),
          defaultValue)
      : defaultValue;
}
