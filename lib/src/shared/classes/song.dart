import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:myartist/src/shared/classes/ranked.dart';
part 'song.g.dart';

@HiveType(typeId: 1)
class Song extends Ranked {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String artist;
  @HiveField(2)
  final String album;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String path;
  @HiveField(5)
  final Duration length;
  @HiveField(6)
  final Uint8List image;

  Song(
    DateTime dateAdded,
    DateTime? dateLastListened,
    int listenCount, {
    required this.id,
    required this.title,
    required this.path,
    required this.album,
    required this.artist,
    required this.length,
    required this.image,
  }) : super(
          dateAdded: dateAdded,
          dateLastListened: dateLastListened,
          listenCount: listenCount,
        );

  @override
  bool operator ==(other) {
    return (other is Song) &&
        this.title == title &&
        this.album == other.album &&
        this.artist == other.artist &&
        this.length == other.length &&
        this.image == other.image;
  }

  @override
  int get hashCode =>
      this.title.hashCode ^
      this.album.hashCode ^
      this.artist.hashCode ^
      this.length.hashCode ^
      this.image.hashCode;
}
