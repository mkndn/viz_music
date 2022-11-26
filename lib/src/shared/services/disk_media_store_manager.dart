import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:mkndn/src/shared/classes/media_content.dart';
import 'package:mkndn/src/shared/mixins/utils.dart';
import 'package:mkndn/src/shared/services/playlist_services.dart';
import 'package:mkndn/src/shared/services/song_services.dart';

import '../classes/song.dart';
import '../mixins/randomness.dart';
import '../mixins/media_util.dart';

class DiskMediaStoreManager with Randomness, MediaUtilMixin {
  final SongService songsService;
  final PlaylistService playlistService;
  static final DiskMediaStoreManager _instance = DiskMediaStoreManager._(
      songsService: SongService.instance(),
      playlistService: PlaylistService.instance());

  DiskMediaStoreManager._({
    required this.songsService,
    required this.playlistService,
  });

  static DiskMediaStoreManager instance() {
    return _instance;
  }

  Stream<Song> generate(List<Future<Metadata>> futureMetadataList) async* {
    Uint8List defaultAlbumArtImage = await cacheDefaultAlbumArt();
    await Future.forEach<Future<Metadata>>(futureMetadataList, (e) async* {
      Metadata metadata = await e;
      String albumName = metadata.albumName ?? '';
      String artistName = combineValues(metadata.trackArtistNames);
      String composedBy = metadata.albumArtistName ?? '';
      Uint8List albumArt =
          metadata.albumArt != null ? metadata.albumArt! : defaultAlbumArtImage;

      if (metadata.filePath != null) {
        yield await _makeSong(
            metadata, albumName, artistName, composedBy, albumArt);
      }
    });
  }

  Future<Song> _makeSong(Metadata metadata, String album, String artist,
      String composedBy, Uint8List albumArt) async {
    return Song(
        dateAdded: DateTime.now(),
        dateLastListened: null,
        listenCount: 0,
        title: metadata.trackName ?? '',
        path: metadata.filePath!,
        album: album,
        artist: artist,
        composedBy: composedBy,
        length: Utils.durationFromMilliseconds(metadata.trackDuration),
        albumCover: albumArt,
        year: metadata.year ?? 9999);
  }

  void updateSong(Song element) =>
      songsService.addItemToBox(item: element, key: element.title);

  void updatePaylist(String playlistTitle, String songTitle) =>
      playlistService.addItemToBox(key: playlistTitle, item: songTitle);

  Future<Uint8List> cacheDefaultAlbumArt() async {
    final File defaultAlbumArt =
        File('${Directory.current.path}/assets/images/record.jpeg');
    return await defaultAlbumArt.readAsBytes();
  }

  void createDefaultPlaylist(List<String> songs, String playlistTitle) {
    playlistService.addItemToBox(key: playlistTitle, item: songs.join(";"));
  }

  Future<void> resetAll() async {
    await songsService.resetBox();
    await playlistService.resetBox();
  }

  MediaContent loadData() {
    return MediaContent.instanceWithSongAndPlaylist(
      songsService.getAllSongs(),
      playlistService.getAllPlaylists(),
    );
  }
}
