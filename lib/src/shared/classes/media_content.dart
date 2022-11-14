import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:myartist/src/shared/classes/album.dart';
import 'package:myartist/src/shared/classes/artist.dart';
import 'package:myartist/src/shared/classes/playlist.dart';
import 'package:myartist/src/shared/classes/song.dart';
import 'package:myartist/src/shared/enums/sorting.dart';
import 'package:myartist/src/shared/mixins/media_sorting.dart';

class MediaContent with MediaSorting {
  final List<Song> _songs;
  final List<Album> _albums;
  final List<Artist> _artists;
  final List<Playlist> _playlists;

  MediaContent(
      {List<Song>? songs,
      List<Album>? albums,
      List<Artist>? artists,
      List<Playlist>? playlists})
      : _songs = songs ?? List.empty(growable: true),
        _albums = albums ?? List.empty(growable: true),
        _artists = artists ?? List.empty(growable: true),
        _playlists = playlists ?? List.empty(growable: true);

  List<Song> get songs => this._songs;

  List<Album> get albums => this._albums;

  List<Artist> get artists => this._artists;

  List<Playlist> get playlists => this._playlists;

  bool equals(other) {
    return (other is MediaContent) &&
        listEquals(this._songs, other._songs) &&
        listEquals(this._albums, other.albums) &&
        listEquals(this._artists, other.artists) &&
        listEquals(this._playlists, other.playlists);
  }

  void addSong(Song song) => this._songs.add(song);

  void setSong(int index, Song song) => this._songs.setAll(index, [song]);

  void removeSong(Song song) => this._songs.remove(song);

  List<Song> getSongsSortedBy(SongSortField sorting) {
    return sortSongsByMixin(this._songs, sorting);
  }

  List<Song> getSongsSortedReversedBy(SongSortField sorting) {
    return sortSongsByMixin(this._songs, sorting).reversed.toList();
  }

  Song? getSongById(String id) {
    return this._songs.firstWhereOrNull((element) => element.id == id);
  }

  List<Song> getSongsById(List<String> ids) {
    return this
        ._songs
        .where((element) => ids.contains(element.id))
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title))
        .toList();
  }

  void removeSongById(String id) {
    this._songs.removeWhere((element) => element.id == id);
  }

  void removeSongsById(List<String> ids) {
    this._songs.removeWhere((element) => ids.contains(element.id));
  }

  void addAlbum(Album album) => this._albums.add(album);

  void setAlbum(int index, Album album) => this._albums.setAll(index, [album]);

  void removeAlbum(Album album) => this._albums.remove(album);

  List<Album> sortAlbumsBy(AlbumSortField sorting) {
    return sortAlbumsByMixin(this._albums, sorting);
  }

  List<Album> sortAlbumsByReversed(AlbumSortField sorting) {
    return sortAlbumsByMixin(this._albums, sorting).reversed.toList();
  }

  Album? getAlbumById(String id) {
    return this._albums.firstWhereOrNull((album) => album.id == id);
  }

  List<Album> getAlbumsById(List<String> ids) {
    return this
        ._albums
        .where((album) => ids.contains(album.id))
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title))
        .toList();
  }

  void removeAlbumById(String id) {
    this._albums.removeWhere((element) => element.id == id);
  }

  void removeAlbumsById(List<String> ids) {
    this._albums.removeWhere((element) => ids.contains(element.id));
  }

  void addArtist(Artist artist) => this._artists.add(artist);

  void setArtist(int index, Artist artist) =>
      this._artists.setAll(index, [artist]);

  void removeArtist(Artist artist) => this._artists.remove(artist);

  List<Artist> getArtistsSortedBy(ArtistSortField sorting) {
    return sortArtistsByMixin(this._artists, sorting);
  }

  List<Artist> getArtistsSortedReversedBy(ArtistSortField sorting) {
    return sortArtistsByMixin(this._artists, sorting).reversed.toList();
  }

  Artist? getArtistById(String id) {
    return this._artists.firstWhereOrNull((element) => element.id == id);
  }

  List<Artist> getArtistsById(List<String> ids) {
    return this
        ._artists
        .where((element) => ids.contains(element.id))
        .whereNotNull()
        .sorted((a, b) => a.name.compareTo(b.name))
        .toList();
  }

  void removeArtistById(String id) {
    this._artists.removeWhere((element) => element.id == id);
  }

  void removeArtistsById(List<String> ids) {
    this._artists.removeWhere((element) => ids.contains(element.id));
  }

  void addPlaylist(Playlist playlist) => this._playlists.add(playlist);

  void setPlaylist(int index, Playlist playlist) =>
      this._playlists.setAll(index, [playlist]);

  void removePlaylist(Playlist playlist) => this._playlists.remove(playlist);

  List<Playlist> getPlaylistsSortedBy(PlaylistSortField sorting) {
    return sortPlaylistsByMixin(this._playlists, sorting);
  }

  List<Playlist> getPlaylistsSortedReversedBy(PlaylistSortField sorting) {
    return sortPlaylistsByMixin(this._playlists, sorting).reversed.toList();
  }

  Playlist? getPlaylistById(String id) {
    return this._playlists.firstWhereOrNull((playlist) => playlist.id == id);
  }

  List<Playlist> getPlaylistsByIds(List<String> ids) {
    return this
        ._playlists
        .where((playlist) => ids.contains(playlist.id))
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title))
        .toList();
  }

  void removePlaylistById(String id) {
    this._playlists.removeWhere((playlist) => playlist.id == id);
  }

  void removePlaylistsById(List<String> ids) {
    this._playlists.removeWhere((playlist) => ids.contains(playlist.id));
  }

  List<Song> getTop5Songs() {
    return this
        ._songs
        .sorted((a, b) => a.listenCount.compareTo(b.listenCount))
        .slice(0, 5)
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title))
        .toList();
  }

  List<Song> recentlyAdded() {
    return this
        ._songs
        .sorted((a, b) => a.dateAdded.compareTo(b.dateAdded))
        .slice(0, 5)
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title))
        .toList();
  }

  List<Song> recentlyListened() {
    return this
        ._songs
        .where((element) => element.dateLastListened != null)
        .sorted((a, b) => a.dateLastListened!.compareTo(b.dateLastListened!))
        .slice(0, 5)
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title))
        .toList();
  }

  List<Album> getTop5Albums() {
    return this
        ._albums
        .sorted((a, b) => a.listenCount.compareTo(b.listenCount))
        .slice(0, 5)
        .whereNotNull()
        .sorted((a, b) => a.title.compareTo(b.title))
        .toList();
  }

  List<Artist> getTop5Artists() {
    return this
        ._artists
        .sorted((a, b) => a.listenCount.compareTo(b.listenCount))
        .slice(0, 5)
        .whereNotNull()
        .sorted((a, b) => a.name.compareTo(b.name))
        .toList();
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
