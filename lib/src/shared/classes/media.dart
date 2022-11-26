import 'package:flutter/foundation.dart';

abstract class Media {
  String get title;
  Uint8List get albumCover;
  String? get composedBy;
  DateTime get dateAdded;
  DateTime? get dateLastListened;
  int get listenCount;
  int get year;
}
