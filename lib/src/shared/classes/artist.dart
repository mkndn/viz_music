import 'package:collection/collection.dart';
import 'package:mkndn/src/shared/classes/song.dart';

class Artist {
  final String name;
  final DateTime dateAdded;
  DateTime? dateLastListened;
  int listenCount;

  Artist({
    required this.dateAdded,
    this.name = '',
    this.dateLastListened = null,
    this.listenCount = 0,
  });

  factory Artist.load(List<Song> songs) {
    return Artist(
      name: songs
              .firstWhereOrNull((element) => element.artist.length > 0)
              ?.title ??
          '',
      dateAdded: songs[0].dateAdded,
      listenCount: songs
          .map((e) => e.listenCount)
          .reduce((song1Count, song2Count) => song1Count + song2Count),
      dateLastListened: songs
          .map((e) => e.dateLastListened)
          .whereType()
          .sorted((a, b) => a.compareTo(b))
          .reversed
          .firstOrNull
          ?.dateLastListened,
    );
  }

  @override
  bool operator ==(other) {
    return (other is Artist) && this.name == name;
  }

  @override
  int get hashCode =>
      this.name.hashCode ^
      this.dateAdded.hashCode ^
      this.dateLastListened.hashCode ^
      this.listenCount.hashCode;
}
