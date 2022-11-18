import 'package:hive/hive.dart';
import 'package:mkndn/src/shared/models/album.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/services/hive_services.dart';
import 'package:objectid/objectid.dart';

class AlbumService extends HiveService<ObjectId, Album> {
  final Box<Album> _box;

  AlbumService._(this._box);

  factory AlbumService.instance() {
    return AlbumService._(Hive.box<Album>(HiveBox.albums.key));
  }

  Box<Album> getBox() => _box;
}
