import 'package:collection/collection.dart';
import 'package:mkndn/src/shared/models/album.dart';
import 'package:mkndn/src/shared/models/artist.dart';
import 'package:mkndn/src/shared/models/playlist.dart';
import 'package:mkndn/src/shared/models/song.dart';
import 'package:mkndn/src/shared/enums/sorting.dart';

mixin MediaSorting {
  List<Song> sortSongsByMixin(List<Song> songs, SongSortField sorting) {
    switch (sorting) {
      case SongSortField.added:
        return songs.sorted((a, b) => a.dateAdded.compareTo(b.dateAdded));
      case SongSortField.listened:
        return songs.sorted((a, b) => a.dateLastListened == null
            ? 1
            : b.dateLastListened == null
                ? -1
                : a.dateLastListened!.compareTo(b.dateLastListened!));
      case SongSortField.frequency:
        return songs.sorted((a, b) => a.listenCount.compareTo(b.listenCount));
      default:
        return songs.sorted((a, b) => a.title.compareTo(b.title));
    }
  }

  List<Album> sortAlbumsByMixin(List<Album> albums, AlbumSortField sorting) {
    switch (sorting) {
      case AlbumSortField.artist:
        return albums.sorted((a, b) => a.albumArtist == null
            ? 1
            : b.albumArtist == null
                ? -1
                : a.albumArtist!.compareTo(b.albumArtist!));
      case AlbumSortField.year:
        return albums.sorted((a, b) => a.year == null
            ? 1
            : b.year == null
                ? -1
                : a.year!.compareTo(b.year!));
      case AlbumSortField.added:
        return albums.sorted((a, b) => a.dateAdded.compareTo(b.dateAdded));
      case AlbumSortField.listened:
        return albums.sorted((a, b) => a.dateLastListened == null
            ? 1
            : b.dateLastListened == null
                ? -1
                : a.dateLastListened!.compareTo(b.dateLastListened!));
      case AlbumSortField.frequency:
        return albums.sorted((a, b) => a.listenCount.compareTo(b.listenCount));
      default:
        return albums.sorted((a, b) => a.title.compareTo(b.title));
    }
  }

  List<Artist> sortArtistsByMixin(
      List<Artist> artists, ArtistSortField sorting) {
    switch (sorting) {
      case ArtistSortField.added:
        return artists.sorted((a, b) => a.dateAdded.compareTo(b.dateAdded));
      case ArtistSortField.listened:
        return artists.sorted((a, b) => a.dateLastListened == null
            ? 1
            : b.dateLastListened == null
                ? -1
                : a.dateLastListened!.compareTo(b.dateLastListened!));
      case ArtistSortField.frequency:
        return artists.sorted((a, b) => a.listenCount.compareTo(b.listenCount));
      default:
        return artists.sorted((a, b) => a.name.compareTo(b.name));
    }
  }

  List<Playlist> sortPlaylistsByMixin(
      List<Playlist> playlists, PlaylistSortField sorting) {
    switch (sorting) {
      case PlaylistSortField.added:
        return playlists.sorted((a, b) => a.dateAdded.compareTo(b.dateAdded));
      case PlaylistSortField.listened:
        return playlists.sorted((a, b) => a.dateLastListened == null
            ? 1
            : b.dateLastListened == null
                ? -1
                : a.dateLastListened!.compareTo(b.dateLastListened!));
      case PlaylistSortField.frequency:
        return playlists
            .sorted((a, b) => a.listenCount.compareTo(b.listenCount));
      default:
        return playlists.sorted((a, b) => a.title.compareTo(b.title));
    }
  }
}
