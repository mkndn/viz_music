import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:myartist/src/shared/models/ranked.dart';
part 'artist.g.dart';

@HiveType(typeId: 3)
class Artist extends Ranked {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<String> albums;

  Artist(
    DateTime dateAdded,
    DateTime? dateLastListened,
    int listenCount, {
    required this.id,
    required this.name,
    required this.albums,
  }) : super(
          dateAdded: dateAdded,
          dateLastListened: dateLastListened,
          listenCount: listenCount,
        );

  @override
  bool operator ==(other) {
    return (other is Artist) &&
        this.name == other.name &&
        this.albums.equals(other.albums);
  }

  @override
  int get hashCode => this.name.hashCode ^ this.albums.hashCode;
}
