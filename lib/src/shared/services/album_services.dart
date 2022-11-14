import 'package:hive/hive.dart';
import 'package:myartist/src/shared/models/album.dart';
import 'package:myartist/src/shared/enums/hive_box.dart';
import 'package:myartist/src/shared/services/hive_services.dart';

class AlbumService extends HiveService<Album> {
  final Box<Album> _box;

  AlbumService._(this._box);

  factory AlbumService.instance() {
    return AlbumService._(Hive.box<Album>(HiveBox.albums.key));
  }

  Box<Album> getBox() => _box;
}
