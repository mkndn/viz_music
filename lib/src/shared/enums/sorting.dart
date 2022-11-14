import 'package:collection/collection.dart';

import '../mixins/utils.dart';

enum SongSortField {
  title('Title'),
  added('Date Added'),
  listened('Recently Listened'),
  frequency('Most Listened');

  final String text;
  const SongSortField(this.text);

  static SongSortField of(String? text, SongSortField defaultValue) =>
      text != null
          ? Utils.defautIfNull(
              () => SongSortField.values
                  .firstWhereOrNull((element) => element.text == text),
              defaultValue)
          : defaultValue;
}

enum AlbumSortField {
  title('Title'),
  artist('Album Artist'),
  year('Album Year'),
  added('Date Added'),
  listened('Recently Listened'),
  frequency('Most Listened');

  final String text;
  const AlbumSortField(this.text);

  static AlbumSortField of(String? text, AlbumSortField defaultValue) =>
      text != null
          ? Utils.defautIfNull(
              () => AlbumSortField.values
                  .firstWhereOrNull((element) => element.text == text),
              defaultValue)
          : defaultValue;
}

enum ArtistSortField {
  name('Name'),
  added('Date Added'),
  listened('Recently Listened'),
  frequency('Most Listened');

  final String text;
  const ArtistSortField(this.text);

  static ArtistSortField of(String? text, ArtistSortField defaultValue) =>
      text != null
          ? Utils.defautIfNull(
              () => ArtistSortField.values
                  .firstWhereOrNull((element) => element.text == text),
              defaultValue)
          : defaultValue;
}

enum PlaylistSortField {
  title('Title'),
  added('Date Added'),
  listened('Recently Listened'),
  frequency('Most Listened');

  final String text;
  const PlaylistSortField(this.text);

  static PlaylistSortField of(String? text, PlaylistSortField defaultValue) =>
      text != null
          ? Utils.defautIfNull(
              () => PlaylistSortField.values
                  .firstWhereOrNull((element) => element.text == text),
              defaultValue)
          : defaultValue;
}
