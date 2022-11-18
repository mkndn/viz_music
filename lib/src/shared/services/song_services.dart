import 'package:hive/hive.dart';
import 'package:mkndn/src/shared/models/song.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/services/hive_services.dart';
import 'package:objectid/objectid.dart';

class SongService extends HiveService<ObjectId, Song> {
  final Box<Song> _box;

  SongService._(this._box);

  factory SongService.instance() {
    return SongService._(Hive.box<Song>(HiveBox.songs.key));
  }

  Box<Song> getBox() => _box;
}
