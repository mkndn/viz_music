import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:mkndn/src/shared/classes/media.dart';
import 'package:mkndn/src/shared/classes/song.dart';

class Album implements Media {
  final List<Song> songs;
  final String title;
  final String? composedBy;
  final Uint8List albumCover;
  final DateTime dateAdded;
  final int year;
  DateTime? dateLastListened;
  int listenCount;

  Album(
      {required this.songs,
      required this.dateAdded,
      required this.albumCover,
      this.title = '',
      this.year = 9999,
      this.composedBy = null,
      this.dateLastListened = null,
      this.listenCount = 0});

  factory Album.load(List<Song> songs) {
    return Album(
      songs: songs,
      albumCover: songs.map((e) => e.albumCover).first,
      title: songs
              .firstWhereOrNull((element) => element.title.length > 0)
              ?.title ??
          '',
      dateAdded: songs[0].dateAdded,
      year: songs[0].year,
      composedBy: songs
          .firstWhereOrNull((element) => element.composedBy.length > 0)
          ?.composedBy,
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
    return (other is Album) && this.title == title;
  }

  @override
  int get hashCode =>
      this.title.hashCode ^
      this.dateAdded.hashCode ^
      this.dateLastListened.hashCode ^
      this.listenCount.hashCode;
}
