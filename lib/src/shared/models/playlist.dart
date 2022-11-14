import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:myartist/src/shared/models/ranked.dart';
part 'playlist.g.dart';

@HiveType(typeId: 4)
class Playlist extends Ranked {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final Uint8List cover;
  @HiveField(4)
  final List<String> songs;

  Playlist(
    DateTime dateAdded,
    DateTime? dateLastListened,
    int listenCount, {
    required this.id,
    required this.title,
    required this.cover,
    required this.songs,
    this.description = '',
  }) : super(
          dateAdded: dateAdded,
          dateLastListened: dateLastListened,
          listenCount: listenCount,
        );

  @override
  bool operator ==(other) {
    return (other is Playlist) &&
        this.title == other.title &&
        this.cover == other.cover &&
        this.songs.equals(other.songs) &&
        this.description == other.description;
  }

  @override
  int get hashCode =>
      this.title.hashCode ^
      this.cover.hashCode ^
      this.songs.hashCode ^
      this.description.hashCode;
}
