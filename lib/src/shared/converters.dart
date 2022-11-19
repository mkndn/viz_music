import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectid/objectid.dart';

class DateTimeConverter extends JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json.contains(".")) {
      json = json.substring(0, json.length - 1);
    }

    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) => object.toIso8601String();
}

class Uint8ListConverter extends JsonConverter<Uint8List, List<int>> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(List<int> json) {
    return Uint8List.fromList(json);
  }

  @override
  List<int> toJson(Uint8List object) {
    return object.toList();
  }
}

class ObjectIdConverter extends JsonConverter<ObjectId, String> {
  const ObjectIdConverter();
  @override
  ObjectId fromJson(String json) {
    return ObjectId.fromHexString(json);
  }

  @override
  String toJson(ObjectId object) {
    return object.hexString;
  }
}

class DurationConverter extends JsonConverter<Duration, int> {
  const DurationConverter();
  @override
  Duration fromJson(int json) {
    return Duration(microseconds: json);
  }

  @override
  int toJson(Duration object) {
    return object.inMicroseconds;
  }
}
