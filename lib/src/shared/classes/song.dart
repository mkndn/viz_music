import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mkndn/src/shared/classes/media.dart';
import 'package:mkndn/src/shared/converters.dart';
part 'song.g.dart';

@JsonSerializable(converters: [
  DateTimeConverter(),
  Uint8ListConverter(),
  DurationConverter(),
])
@HiveType(typeId: 1)
class Song implements Media {
  @HiveField(0)
  final String artist;
  @HiveField(1)
  final String album;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String composedBy;
  @HiveField(4)
  final int year;
  @HiveField(5)
  final String path;
  @HiveField(6)
  final Duration length;
  @HiveField(7)
  final Uint8List albumCover;
  @HiveField(8)
  int listenCount;
  @HiveField(9)
  final DateTime dateAdded;
  @HiveField(10)
  DateTime? dateLastListened;

  Song({
    required this.title,
    required this.path,
    required this.album,
    required this.year,
    required this.artist,
    required this.composedBy,
    required this.length,
    required this.albumCover,
    required this.listenCount,
    required this.dateAdded,
    required this.dateLastListened,
  });

  @override
  bool operator ==(other) {
    return (other is Song) &&
        this.title == title &&
        this.album == other.album &&
        this.artist == other.artist &&
        this.year == other.year &&
        this.composedBy == other.composedBy &&
        this.length == other.length &&
        this.albumCover == other.albumCover;
  }

  @override
  int get hashCode =>
      this.title.hashCode ^
      this.album.hashCode ^
      this.year.hashCode ^
      this.artist.hashCode ^
      this.composedBy.hashCode ^
      this.length.hashCode ^
      this.albumCover.hashCode;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}
