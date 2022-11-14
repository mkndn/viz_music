import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:myartist/src/shared/classes/media_content.dart';
import 'package:myartist/src/shared/classes/song.dart';
import 'package:myartist/src/shared/mixins/utils.dart';
import 'package:myartist/src/shared/services/album_services.dart';
import 'package:myartist/src/shared/services/artist_services.dart';
import 'package:myartist/src/shared/services/hive_services.dart';
import 'package:myartist/src/shared/services/playlist_services.dart';
import 'package:myartist/src/shared/services/song_services.dart';

import '../classes/album.dart';
import '../classes/artist.dart';
import '../classes/playlist.dart';
import '../mixins/randomness.dart';
import '../mixins/media_util.dart';

class DiskMediaStoreManager with Randomness, MediaUtilMixin {
  final HiveService<Song> songsService;
  final HiveService<Album> albumService;
  final HiveService<Artist> artistService;
  final HiveService<Playlist> playlistService;
  static final DiskMediaStoreManager _instance = DiskMediaStoreManager._(
      songsService: SongService.instance(),
      albumService: AlbumService.instance(),
      artistService: ArtistService.instance(),
      playlistService: PlaylistService.instance());

  DiskMediaStoreManager._({
    required this.songsService,
    required this.albumService,
    required this.artistService,
    required this.playlistService,
  });

  static DiskMediaStoreManager instance() {
    return _instance;
  }

  Future<MediaContent> generate(
      List<Future<Metadata>> futureMetadataList) async {
    MediaContent mediaContent = MediaContent();
    Uint8List defaultAlbumArtImage = await cacheDefaultAlbumArt();
    await Future.forEach<Future<Metadata>>(futureMetadataList, (e) async {
      Metadata metadata = await e;
      String albumName = metadata.albumName ?? '';
      Album? matchedAlbum = mediaContent.albums
          .firstWhereOrNull((element) => element.title == albumName);
      String albumId =
          matchedAlbum != null ? matchedAlbum.id : randomStringId(6);

      String artistName = combineValues(metadata.trackArtistNames);
      Artist? matchedArtist = mediaContent.artists
          .firstWhereOrNull((element) => element.name == artistName);
      String artistId =
          matchedArtist != null ? matchedArtist.id : randomStringId(6);

      Uint8List albumArt =
          metadata.albumArt != null ? metadata.albumArt! : defaultAlbumArtImage;

      if (metadata.filePath != null) {
        Song song = await _makeSong(metadata, albumId, artistId, albumArt);

        mediaContent.addSong(song);

        if (matchedAlbum != null) {
          int index = mediaContent.albums.indexOf(matchedAlbum);
          if (!matchedAlbum.songsInAlbum.contains(song.id)) {
            matchedAlbum.songsInAlbum.add(song.id);
            mediaContent.setAlbum(index, matchedAlbum);
          }
        } else {
          mediaContent.addAlbum(
            Album(
              DateTime.now(),
              null,
              0,
              id: albumId,
              title: albumName,
              image: albumArt,
              albumArtist: metadata.albumArtistName,
              year: metadata.year?.toString(),
              songsInAlbum: List<String>.of([song.id]),
            ),
          );
        }

        if (matchedArtist != null) {
          int index = mediaContent.artists.indexOf(matchedArtist);
          if (!matchedArtist.albums.contains(albumId)) {
            matchedArtist.albums.add(albumId);
            mediaContent.setArtist(index, matchedArtist);
          }
        } else {
          mediaContent.addArtist(
            Artist(
              DateTime.now(),
              null,
              0,
              id: artistId,
              name: artistName,
              albums: List<String>.of([albumId]),
            ),
          );
        }
      }
    });
    return await generateDefaultPlaylist(mediaContent, defaultAlbumArtImage)
        .then((value) {
      persistData(mediaContent);
      return mediaContent;
    });
  }

  Future<Song> _makeSong(Metadata metadata, String album, String artist,
      Uint8List albumArt) async {
    return Song(
      DateTime.now(),
      null,
      0,
      id: randomStringId(6),
      title: metadata.trackName ?? '',
      path: metadata.filePath!,
      album: album,
      artist: artist,
      length: Utils.durationFromMilliseconds(metadata.trackDuration),
      image: albumArt,
    );
  }

  void persistData(MediaContent mediaContent) {
    mediaContent.songs.forEach((element) {
      updateSong(element);
    });
    mediaContent.albums.forEach((element) {
      updateAlbum(element);
    });
    mediaContent.artists.forEach((element) {
      updateArtist(element);
    });
    mediaContent.playlists.forEach((element) {
      updatePaylist(element);
    });
  }

  void updateSong(Song element) =>
      songsService.addItemToBox(item: element, key: element.id);

  void updateAlbum(Album element) =>
      albumService.addItemToBox(item: element, key: element.id);

  void updateArtist(Artist element) =>
      artistService.addItemToBox(item: element, key: element.id);

  void updatePaylist(Playlist element) =>
      playlistService.addItemToBox(item: element, key: element.id);

  Future<Uint8List> cacheDefaultAlbumArt() async {
    final File defaultAlbumArt =
        File('${Directory.current.path}/assets/images/record.jpeg');
    return await defaultAlbumArt.readAsBytes();
  }

  Future<void> generateDefaultPlaylist(
      MediaContent mediaContent, Uint8List albumArt) async {
    List<String> songs = mediaContent.songs.map((e) => e.id).toList();
    mediaContent.addPlaylist(
      Playlist(
        DateTime.now(),
        null,
        0,
        id: randomStringId(6),
        title: 'JM Playlist',
        cover: albumArt,
        songs: songs,
      ),
    );
  }

  void resetAll() {
    songsService.resetBox();
    albumService.resetBox();
    artistService.resetBox();
    playlistService.resetBox();
  }

  MediaContent loadData() {
    return MediaContent(
        songs: songsService.getAllItems(),
        albums: albumService.getAllItems(),
        artists: artistService.getAllItems(),
        playlists: playlistService.getAllItems());
  }
}
