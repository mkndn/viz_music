import 'package:hive/hive.dart';
import 'package:myartist/src/shared/classes/playlist.dart';
import 'package:myartist/src/shared/enums/hive_box.dart';
import 'package:myartist/src/shared/services/hive_services.dart';

class PlaylistService extends HiveService<Playlist> {
  final Box<Playlist> _box;

  PlaylistService._(this._box);

  factory PlaylistService.instance() {
    return PlaylistService._(Hive.box<Playlist>(HiveBox.playlists.key));
  }

  Box<Playlist> getBox() => _box;
}
