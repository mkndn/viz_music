import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:myartist/src/shared/classes/classes.dart';
import 'package:myartist/src/shared/classes/media_content.dart';
import 'package:myartist/src/shared/enums/hive_box.dart';
import 'package:myartist/src/shared/providers/preferences.dart';
import 'package:myartist/src/shared/services/disk_media_store_manager.dart';

class InMemoryMediaManager extends StatefulWidget {
  final Widget child;

  const InMemoryMediaManager({
    required this.child,
    super.key,
  });

  static InMemoryMediaManagerState of(BuildContext context, {HiveBox? aspect}) {
    return InheritedModel.inheritFrom<_Media>(context, aspect: aspect)!.data;
  }

  @override
  State<InMemoryMediaManager> createState() => InMemoryMediaManagerState();
}

class InMemoryMediaManagerState extends State<InMemoryMediaManager> {
  MediaContent content = MediaContent();
  final DiskMediaStoreManager _diskMediaManager =
      DiskMediaStoreManager.instance();

  Future<void> _reload() async {
    final Preferences _prefs = Preferences();

    await _prefs.getStringList('Folders.included').then((paths) async {
      final List<Future<MediaContent>> mediaContentFutureList =
          List.empty(growable: true);
      for (var element in paths) {
        List<Future<Metadata>> songMetadataList = List.empty(growable: true);
        List<FileSystemEntity> entities = Directory(element)
            .listSync()
            .where((element) => element.path.endsWith(".mp3"))
            .toList();
        for (var element in entities) {
          songMetadataList.add(MetadataRetriever.fromFile(File(element.path)));
        }
        if (songMetadataList.isNotEmpty) {
          mediaContentFutureList
              .add(_diskMediaManager.generate(songMetadataList));
        }
      }

      await Future.wait(mediaContentFutureList).then((mediaContentList) async {
        update(mediaContentList.last);
      });
    });
  }

  void rankMedia(String songId) {
    int matchedIndex = content.songs.indexWhere((song) => song.id == songId);
    if (matchedIndex >= 0) {
      Song matched = content.songs.elementAt(matchedIndex);
      rankSong(matched, matchedIndex);
      rankAlbum(matched.album);
      rankArtist(matched.artist);
      update(content);
    }
  }

  void rankSong(Song song, int index) {
    song.listenCount += 1;
    song.dateLastListened = DateTime.now();
    _diskMediaManager.updateSong(song);
    content.songs.setAll(index, [song]);
  }

  void rankAlbum(String id) {
    int matchedIndex = content.albums.indexWhere((song) => song.id == id);
    if (matchedIndex >= 0) {
      Album matched = content.albums.elementAt(matchedIndex);
      matched.listenCount += 1;
      matched.dateLastListened = DateTime.now();
      _diskMediaManager.updateAlbum(matched);
      content.albums.setAll(matchedIndex, [matched]);
    }
  }

  void rankArtist(String id) {
    int matchedIndex = content.artists.indexWhere((song) => song.id == id);
    if (matchedIndex >= 0) {
      Artist matched = content.artists.elementAt(matchedIndex);
      matched.listenCount += 1;
      matched.dateLastListened = DateTime.now();
      _diskMediaManager.updateArtist(matched);
      content.artists.setAll(matchedIndex, [matched]);
    }
  }

  Future<void> init() async {
    MediaContent content = _diskMediaManager.loadData();
    if (content.hasContent) {
      update(content);
    } else {
      await _reload();
    }
  }

  Future<void> refresh() async {
    reset();
    await _reload();
  }

  Future<void> reset() async {
    _diskMediaManager.resetAll();
    update(MediaContent());
  }

  void update(MediaContent mediaContent) {
    setState(() {
      this.content = mediaContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Media(
      data: this,
      child: widget.child,
    );
  }
}

class _Media extends InheritedModel<HiveBox> {
  final InMemoryMediaManagerState data;

  _Media({required this.data, required super.child});

  MediaContent get content => data.content;

  @override
  bool updateShouldNotify(covariant _Media old) {
    return !this.data.content.equals(old.data.content);
  }

  @override
  bool updateShouldNotifyDependent(
      covariant _Media old, Set<HiveBox> dependencies) {
    return (dependencies.contains(HiveBox.songs) &&
            !listEquals(this.content.songs, old.content.songs)) ||
        (dependencies.contains(HiveBox.albums) &&
            !listEquals(this.content.albums, old.content.albums)) ||
        (dependencies.contains(HiveBox.artists) &&
            !listEquals(this.content.artists, old.content.artists)) ||
        (dependencies.contains(HiveBox.playlists) &&
            !listEquals(this.content.playlists, old.content.playlists));
  }
}
