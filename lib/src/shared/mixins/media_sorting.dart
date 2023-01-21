import 'package:collection/collection.dart';
import 'package:mkndn/src/shared/classes/album.dart';
import 'package:mkndn/src/shared/classes/artist.dart';
import 'package:mkndn/src/shared/extensions.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/enums/sorting.dart';

mixin MediaSorting {
  List<T> processReversed<T>(List<T> originalList, bool isReversed) =>
      isReversed ? originalList.reversed.toList() : originalList;

  List<Song> sortSongsByMixin(
      List<Song> songs, SongSortField sorting, bool isReversed) {
    switch (sorting) {
      case SongSortField.added:
        return processReversed(
            songs.sorted(
              (a, b) => a.dateAdded.compareTo(b.dateAdded),
            ),
            isReversed);
      case SongSortField.listened:
        return processReversed(
            songs.sorted(
              (a, b) => a.dateLastListened == null
                  ? 1
                  : b.dateLastListened == null
                      ? -1
                      : a.dateLastListened!.compareTo(b.dateLastListened!),
            ),
            isReversed);
      case SongSortField.frequency:
        return processReversed(
            songs.sorted(
              (a, b) => a.listenCount.compareTo(b.listenCount),
            ),
            isReversed);
      default:
        return processReversed(
            songs.sorted(
              (a, b) => a.title.compareTo(b.title),
            ),
            isReversed);
    }
  }

  List<Album> sortAlbumsByMixin(
      List<Album> albums, AlbumSortField sorting, bool isReversed) {
    switch (sorting) {
      case AlbumSortField.artist:
        return processReversed(
            albums.sorted((a, b) => a.composedBy.compareNullable(b.composedBy)),
            isReversed);
      case AlbumSortField.year:
        return processReversed(
            albums.sorted(
              (a, b) => a.year.compareTo(b.year),
            ),
            isReversed);
      case AlbumSortField.added:
        return processReversed(
            albums.sorted(
              (a, b) => a.dateAdded.compareTo(b.dateAdded),
            ),
            isReversed);
      case AlbumSortField.listened:
        return processReversed(
            albums.sorted((a, b) =>
                a.dateLastListened.compareNullable(b.dateLastListened)),
            isReversed);
      case AlbumSortField.frequency:
        return processReversed(
            albums.sorted(
              (a, b) => a.listenCount.compareTo(b.listenCount),
            ),
            isReversed);
      default:
        return processReversed(
            albums.sorted((a, b) => a.title.compareNullable(b.title)),
            isReversed);
    }
  }

  List<Artist> sortArtistsByMixin(
      List<Artist> artists, ArtistSortField sorting, bool isReversed) {
    switch (sorting) {
      case ArtistSortField.added:
        return processReversed(
            artists.sorted((a, b) => a.dateAdded.compareTo(b.dateAdded)),
            isReversed);
      case ArtistSortField.listened:
        return processReversed(
            artists.sorted((a, b) =>
                a.dateLastListened.compareNullable(b.dateLastListened!)),
            isReversed);
      case ArtistSortField.frequency:
        return processReversed(
            artists.sorted((a, b) => a.listenCount.compareTo(b.listenCount)),
            isReversed);
      default:
        return processReversed(
            artists.sorted((a, b) => a.title.compareTo(b.title)), isReversed);
    }
  }
}
