import 'package:hive/hive.dart';
import 'package:mkndn/src/shared/models/artist.dart';
import 'package:mkndn/src/shared/enums/hive_box.dart';
import 'package:mkndn/src/shared/services/hive_services.dart';
import 'package:objectid/objectid.dart';

class ArtistService extends HiveService<ObjectId, Artist> {
  final Box<Artist> _box;

  ArtistService._(this._box);

  factory ArtistService.instance() {
    return ArtistService._(Hive.box<Artist>(HiveBox.artists.key));
  }

  Box<Artist> getBox() => _box;
}
