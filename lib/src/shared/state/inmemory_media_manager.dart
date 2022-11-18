import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:mkndn/src/shared/classes/classes.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/enums/state.dart';
import 'package:mkndn/src/shared/mixins/folder.dart';
import 'package:mkndn/src/shared/models/album.dart';
import 'package:mkndn/src/shared/models/artist.dart';
import 'package:mkndn/src/shared/models/song.dart';
import 'package:mkndn/src/shared/providers/preferences.dart';
import 'package:mkndn/src/shared/services/disk_media_store_manager.dart';
import 'package:objectid/objectid.dart';

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

class InMemoryMediaManagerState extends State<InMemoryMediaManager>
    with FolderMixin {
  MediaContent content = MediaContent();
  final DiskMediaStoreManager _diskMediaManager =
      DiskMediaStoreManager.instance();
  final Preferences _prefs = Preferences();

  List<FileSystemEntity> getEntities(String path) => Directory(path)
      .listSync()
      .where((element) => element.path.endsWith(".mp3"))
      .toList();

  Future<void> _reload() async {
    final List<Future<MediaContent>> mediaContentFutureList =
        List.empty(growable: true);
    deSerialiseFolders(await _prefs.getStringList(FolderMode.included.text))
        .forEach((folder) async {
      List<Future<Metadata>> songMetadataList = List.empty(growable: true);
      List<FileSystemEntity> entities = getEntities(folder.path);
      for (var element in entities) {
        songMetadataList.add(MetadataRetriever.fromFile(File(element.path)));
      }
      if (songMetadataList.isNotEmpty) {
        updateFolderInPrefs(folder.copyWith(hasContent: false));
        mediaContentFutureList
            .add(_diskMediaManager.generate(songMetadataList));
      }
    });

    await Future.wait(mediaContentFutureList).then((mediaContentList) async {
      update(mediaContentList.last);
    });
  }

  void updateFolderInPrefs(Folder folder) async {
    _prefs.setStringList(
        FolderMode.included.text,
        updateFolder(await _prefs.getStringList(FolderMode.included.text),
            folder.path, (f) => folder.copyWith(hasContent: true)));
  }

  Future<bool> areFolderConfigIntact() async {
    return areFoldersIntact(await _prefs.getStringList('Folders.included'),
        (path) => getEntities(path).length > 0);
  }

  Future<void> init() async {
    bool folderIntact = await areFolderConfigIntact();
    if (folderIntact) {
      MediaContent content = _diskMediaManager.loadData();
      if (content.hasContent) {
        update(content);
      } else {
        await _reload();
      }
    }
  }

  Future<void> refresh() async {
    resetAppData();
    await _reload();
  }

  Future<void> resetAppData() async {
    await _diskMediaManager.resetAll();
    update(MediaContent());
  }

  Future<void> resetSettings() async {
    await _prefs.reset();
  }

  void update(MediaContent mediaContent) {
    setState(() {
      this.content = mediaContent;
    });
  }

  void rankMedia(ObjectId songId) {
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

  void rankAlbum(ObjectId id) {
    int matchedIndex = content.albums.indexWhere((song) => song.id == id);
    if (matchedIndex >= 0) {
      Album matched = content.albums.elementAt(matchedIndex);
      matched.listenCount += 1;
      matched.dateLastListened = DateTime.now();
      _diskMediaManager.updateAlbum(matched);
      content.albums.setAll(matchedIndex, [matched]);
    }
  }

  void rankArtist(ObjectId id) {
    int matchedIndex = content.artists.indexWhere((song) => song.id == id);
    if (matchedIndex >= 0) {
      Artist matched = content.artists.elementAt(matchedIndex);
      matched.listenCount += 1;
      matched.dateLastListened = DateTime.now();
      _diskMediaManager.updateArtist(matched);
      content.artists.setAll(matchedIndex, [matched]);
    }
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
