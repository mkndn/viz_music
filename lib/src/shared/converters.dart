import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

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

class Uint8ListConverter extends JsonConverter<Uint8List, String> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(String json) {
    return new Uint8List.fromList(json.codeUnits);
  }

  @override
  String toJson(Uint8List object) {
    return new String.fromCharCodes(object);
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
