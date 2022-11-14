import 'package:myartist/src/shared/extensions.dart';

class Utils {
  static T defautIfNull<T>(T? Function() func, T defaultValue) {
    return func() ?? defaultValue;
  }

  static Duration durationFromMilliseconds(int? milliseconds) {
    return milliseconds != null
        ? Duration(milliseconds: milliseconds)
        : '0:00'.toDuration();
  }
}
