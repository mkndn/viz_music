import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mkndn/src/shared/converters.dart';
import 'package:mkndn/src/shared/models/ranked.dart';
import 'package:objectid/objectid.dart';
part 'song.g.dart';

@JsonSerializable(converters: [
  DateTimeConverter(),
  Uint8ListConverter(),
  ObjectIdConverter(),
  DurationConverter(),
])
@HiveType(typeId: 1)
class Song extends Ranked {
  @HiveField(0)
  final ObjectId id;
  @HiveField(1)
  final ObjectId artist;
  @HiveField(2)
  final ObjectId album;
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

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);
}
