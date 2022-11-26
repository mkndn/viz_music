import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mkndn/src/shared/classes/song_queue.dart';

class SongQueueAdapter extends TypeAdapter<SongQueue> {
  @override
  final typeId = 13;

  @override
  void write(BinaryWriter writer, SongQueue value) =>
      writer.writeString(jsonEncode(value.toJson()));

  @override
  SongQueue read(BinaryReader reader) =>
      SongQueue.fromJson(jsonDecode(reader.readString()));
}
