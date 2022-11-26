import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:mkndn/src/shared/classes/classes.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/enums/state.dart';
import 'package:mkndn/src/shared/mixins/folder.dart';
import 'package:mkndn/src/shared/classes/song.dart';
import 'package:mkndn/src/shared/providers/preferences.dart';
import 'package:mkndn/src/shared/services/disk_media_store_manager.dart';

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
  MediaContent content = MediaContent.instance();
  final DiskMediaStoreManager _diskMediaManager =
      DiskMediaStoreManager.instance();
  final Preferences _prefs = Preferences();

  List<FileSystemEntity> getEntities(String path) => Directory(path)
      .listSync()
      .where((element) => element.path.endsWith(".mp3"))
      .toList();

  Stream<Song> _reload() async* {
    deSerialiseFolders(await _prefs.getStringList(FolderMode.included.text))
        .forEach((folder) async {
      List<Future<Metadata>> songMetadataList = List.empty(growable: true);
      List<FileSystemEntity> entities = getEntities(folder.path);
      for (var element in entities) {
        songMetadataList.add(MetadataRetriever.fromFile(File(element.path)));
      }
      if (songMetadataList.isNotEmpty) {
        updateFolderInPrefs(folder.copyWith(hasContent: false));
        _diskMediaManager.generate(songMetadataList);
      }
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
        resetAppData();

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
    setState(() {
      this.content.reset();
    });
  }

  Future<void> resetSettings() async {
    await _prefs.reset();
  }

  void update(MediaContent mediaContent) {
    setState(() {
      this.content = mediaContent;
    });
  }

  void rankMedia(String songTitle) {
    int matchedIndex = content.getSongIndex(songTitle);
    if (matchedIndex >= 0) {
      Song matched = content.songs.elementAt(matchedIndex);
      rankSong(matched, matchedIndex);
      content.albumRefresh = true;
      content.artistRefresh = true;
      update(content);
    }
  }

  void rankSong(Song song, int index) {
    song.listenCount += 1;
    song.dateLastListened = DateTime.now();
    _diskMediaManager.updateSong(song);
    content.songs.setAll(index, [song]);
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
    return this.data.content != old.data.content;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant _Media old, Set<HiveBox> dependencies) {
    return (dependencies.contains(HiveBox.songs) &&
            !listEquals(this.content.songs, old.content.songs)) ||
        (dependencies.contains(HiveBox.playlists) &&
            this.content.playlists != old.content.playlists);
  }
}
