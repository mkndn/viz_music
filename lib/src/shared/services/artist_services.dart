import 'package:hive/hive.dart';
import 'package:myartist/src/shared/classes/artist.dart';
import 'package:myartist/src/shared/enums/hive_box.dart';
import 'package:myartist/src/shared/services/hive_services.dart';

class ArtistService extends HiveService<Artist> {
  final Box<Artist> _box;

  ArtistService._(this._box);

  factory ArtistService.instance() {
    return ArtistService._(Hive.box<Artist>(HiveBox.artists.key));
  }

  Box<Artist> getBox() => _box;
}
