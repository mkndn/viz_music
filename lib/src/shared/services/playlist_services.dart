import 'dart:core';

import 'package:hive/hive.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/services/hive_services.dart';
import 'package:mkndn/src/shared/typedefs.dart';

/**
 * Manages hive box for playlists. Playlists songs are maintain as individual entries and not as list
 * for easier playlist manipulation.
 * Entries are stores as playlistTitle as key and song titles as colon-spearated strings 
 */
class PlaylistService extends HiveService<String> {
  final Box<String> _box;

  PlaylistService._(this._box);

  factory PlaylistService.instance() {
    return PlaylistService._(Hive.box<String>(HiveBox.playlists.key));
  }

  Box<String> getBox() => _box;

  MapOfStringList getAllPlaylists() => Map.fromEntries(
        getKeyValuePairs().entries.map(
              (e) => MapEntry(
                e.key as String,
                e.value.split(";"),
              ),
            ),
      );
}
