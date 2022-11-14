import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:myartist/src/shared/models/ranked.dart';
part 'album.g.dart';

@HiveType(typeId: 2)
class Album extends Ranked {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final Uint8List image;
  @HiveField(3)
  final String? albumArtist;
  @HiveField(4)
  final String? year;
  @HiveField(5)
  final List<String> songsInAlbum;

  Album(
    DateTime dateAdded,
    DateTime? dateLastListened,
    int listenCount, {
    required this.id,
    required this.title,
    required this.image,
    required this.songsInAlbum,
    this.albumArtist,
    this.year,
  }) : super(
          dateAdded: dateAdded,
          dateLastListened: dateLastListened,
          listenCount: listenCount,
        );

  @override
  bool operator ==(other) {
    return (other is Album) &&
        this.title == other.title &&
        this.image == other.image &&
        this.albumArtist == other.albumArtist &&
        this.year == other.year &&
        this.songsInAlbum.equals(other.songsInAlbum);
  }

  @override
  int get hashCode =>
      this.title.hashCode ^
      this.image.hashCode ^
      this.albumArtist.hashCode ^
      this.year.hashCode ^
      this.songsInAlbum.hashCode;
}
