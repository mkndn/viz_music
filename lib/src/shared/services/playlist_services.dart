import 'package:hive/hive.dart';
import 'package:mkndn/src/shared/models/playlist.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/services/hive_services.dart';

class PlaylistService extends HiveService<Playlist> {
  final Box<Playlist> _box;

  PlaylistService._(this._box);

  factory PlaylistService.instance() {
    return PlaylistService._(Hive.box<Playlist>(HiveBox.playlists.key));
  }

  Box<Playlist> getBox() => _box;
}
