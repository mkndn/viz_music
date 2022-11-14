import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Preferences? _instance;
  Future<SharedPreferences> _prefs;

  Preferences._(this._prefs);

  factory Preferences() {
    _instance ??= Preferences._(SharedPreferences.getInstance());
    return _instance!;
  }

  Future<Object?> getValue(String key) async {
    return await _prefs.then((value) => value.get(key));
  }

  Future<bool> getBool(String key) async {
    return _prefs
        .then((value) => value.getBool(key))
        .then((boolValue) => boolValue ?? false);
  }

  Future<int?> getInt(String key) async {
    return await _prefs.then((value) => value.getInt(key));
  }

  Future<double?> getDouble(String key) async {
    return await _prefs.then((value) => value.getDouble(key));
  }

  Future<String?> getString(String key) async {
    return await _prefs.then((value) => value.getString(key));
  }

  Future<List<String>> getStringList(String key) async {
    return await _prefs
        .then((value) => value.getStringList(key))
        .then((value) => value ?? List.empty());
  }

  Future<void> setBool(String key, bool val) async {
    await _prefs.then((value) => value.setBool(key, val));
  }

  Future<void> setInt(String key, int val) async {
    await _prefs.then((value) => value.setInt(key, val));
  }

  Future<void> setDouble(String key, double val) async {
    await _prefs.then((value) => value.setDouble(key, val));
  }

  Future<void> setString(String key, String val) async {
    await _prefs.then((value) => value.setString(key, val));
  }

  Future<void> setStringList(String key, List<String> val) async {
    await _prefs.then((value) => value.setStringList(key, val));
  }
}
