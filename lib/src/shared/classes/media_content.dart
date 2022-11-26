import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:mkndn/src/shared/classes/album.dart';
import 'package:mkndn/src/shared/classes/artist.dart';
import 'package:mkndn/src/shared/mixins/media_util.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/enums/sorting.dart';
import 'package:mkndn/src/shared/mixins/media_sorting.dart';
import 'package:mkndn/src/shared/typedefs.dart';

class MediaContent with MediaSorting, MediaUtilMixin {
  static final MediaContent _instance = MediaContent._();
  final List<Song> _songs = List.empty(growable: true);
  final MapOfStringList _playlists = Map();
  final List<Album> _albums = List.empty(growable: true);
  final List<Artist> _artists = List.empty(growable: true);
  bool _albumRefresh = false;
  bool _artistRefresh = false;

  MediaContent._();

  factory MediaContent.instance() => _instance;

  factory MediaContent.instanceWithSong(List<Song> songs) {
    _instance._songs.addAll(songs);
    return _instance;
  }

  factory MediaContent.instanceWithSongAndPlaylist(
      List<Song> songs, MapOfStringList playlists) {
    _instance._songs.addAll(songs);
    _instance._playlists.addAll(playlists);
    return _instance;
  }

  @override
  int get hashCode =>
      this._songs.hashCode ^
      this._albums.hashCode ^
      this._artists.hashCode ^
      this._playlists.hashCode;

  @override
  bool operator ==(other) =>
      (other is MediaContent) &&
      listEquals(this._songs, other.songs) &&
      listEquals(this._albums, other.albums) &&
      listEquals(this._artists, other.artists) &&
      mapEquals(this._playlists, other.playlists);

  List<Song> get songs => this._songs;

  List<Album> get albums => this._albums;

  List<Artist> get artists => this._artists;

  MapOfStringList get playlists => this._playlists;

  void set albumRefresh(bool status) => this._albumRefresh = status;

  void set artistRefresh(bool status) => this._artistRefresh = status;

  int getSongIndex(String songTitle) =>
      this._songs.indexWhere((song) => song.title == songTitle);

  List<String> get playlistTitles => this._playlists.keys.toList();

  void removeSong(Song song) => this._songs.remove(song);

  List<Song> getSongsSortedBy(SongSortField sorting, bool isReversed) {
    return sortSongsByMixin(this._songs, sorting, isReversed);
  }

  Song? getSongByTitle(String songTitle) {
    return this._songs.firstWhereOrNull((song) => song.title == songTitle);
  }

  List<Song> getSongsByTitles(List<String> songTitles) {
    return this
        ._songs
        .where((song) => songTitles.contains(song.title))
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title))
        .toList();
  }

  void removeSongByTitle(String songTitle) {
    this._songs.removeWhere((song) => song.title == songTitle);
  }

  void removeSongsByTitles(List<String> songTitles) {
    this._songs.removeWhere((song) => songTitles.contains(song.title));
  }

  Stream<Song> getPlaylistSongs(String playlistTitle) async* {
    this._playlists[playlistTitle]!.forEach((songTitle) async* {
      yield getSongByTitle(songTitle);
    });
  }

  void addSongToPlaylist(String playlistTitle, String songTitle) =>
      this._playlists[playlistTitle]!.add(songTitle);

  void removeSongFromPlaylist(String playlistTitle, String songTitle) =>
      this._playlists[playlistTitle]!.remove(songTitle);

  void removePlaylist(String playlistTitle) {
    this._playlists.remove(playlistTitle);
  }

  Stream<Album> getAlbums() async* {
    if (this._albums.isNotEmpty && !this._albumRefresh) {
      this._albums.forEach((album) async* {
        yield album;
      });
    } else {
      this.albumRefresh = false;
      groupByAndStreamWithPersist<Song, Album>(
          () => this._songs.groupListsBy((element) => element.album),
          (List<Song> songs) => Album.load(songs),
          (Album album) => this._albums.add(album));
    }
  }

  Album? getAlbumByTitle(String albumTitle) {
    return this._albums.firstWhereOrNull((album) => album.title == albumTitle);
  }

  List<Album> getAlbumsByTitles(List<String> albumTitles) {
    return this
        ._albums
        .where((album) => albumTitles.contains(album.title))
        .toList();
  }

  List<Album> sortAlbumsBy(AlbumSortField sorting, bool isReversed) {
    return sortAlbumsByMixin(this._albums, sorting, isReversed);
  }

  int getAlbumIndex(String albumTitle) =>
      this._albums.indexWhere((album) => album.title == albumTitle);

  Stream<Artist> getArtists() async* {
    if (this._artists.isNotEmpty && !this._artistRefresh) {
      this._artists.forEach((artist) async* {
        yield artist;
      });
    } else {
      this.artistRefresh = false;
      groupByAndStreamWithPersist<Song, Artist>(
          () => this._songs.groupListsBy((element) => element.artist),
          (List<Song> songs) => Artist.load(songs),
          (Artist artist) => this._artists.add(artist));
    }
  }

  Stream<Album> getArtistAlbums(String artistTitle) async* {
    groupByAndStreamWithFilter<Song, Album>(
      () => this
          ._songs
          .where((element) => element.artist == artistTitle)
          .toList(),
      (List<Song> songs) => songs.groupListsBy((element) => element.album),
      (String albumTitle, List<Song> songs) {
        Album? filtered =
            this._albums.firstWhereOrNull((album) => album.title == albumTitle);
        if (filtered != null) {
          return filtered;
        } else {
          Album loaded = Album.load(songs);
          this._albums.add(loaded);
          return loaded;
        }
      },
    );
  }

  Artist? getArtistByTitle(String artistName) {
    return this
        ._artists
        .firstWhereOrNull((artist) => artist.name == artistName);
  }

  List<Artist> sortArtistsBy(ArtistSortField sorting, bool isReversed) {
    return sortArtistsByMixin(this._artists, sorting, isReversed);
  }

  int getArtistIndex(String artistName) =>
      this._artists.indexWhere((artist) => artist.name == artistName);

  List<Song> getTop5Songs() {
    return this
        .getSongsSortedBy(SongSortField.frequency, true)
        .slice(0, 5)
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title));
  }

  List<Song> recentlyAdded() {
    return this
        .getSongsSortedBy(SongSortField.added, true)
        .slice(0, 5)
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title));
  }

  List<Song> recentlyListened() {
    return this
        .getSongsSortedBy(SongSortField.listened, true)
        .slice(0, 5)
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title));
  }

  List<Album> getTop5Albums() {
    return this
        .sortAlbumsBy(AlbumSortField.frequency, true)
        .take(5)
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title));
  }

  List<Artist> getTop5Artists() {
    return this
        .sortArtistsBy(ArtistSortField.listened, true)
        .take(5)
        .whereNotNull()
        .sorted((a, b) => a.name.compareTo(b.name));
  }

  bool isLoaded() =>
      this._songs.isNotEmpty &&
      this._artists.isNotEmpty &&
      this._albums.isNotEmpty &&
      this._playlists.isNotEmpty;

  bool get hasContent =>
      this._songs.isNotEmpty &&
      this._albums.isNotEmpty &&
      this._artists.isNotEmpty &&
      this._playlists.isNotEmpty;

  void reset() {
    this._songs.clear();
    this._albums.clear();
    this._artists.clear();
    this._playlists.clear();
  }
}
