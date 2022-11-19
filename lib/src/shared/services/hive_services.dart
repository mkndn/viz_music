import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveService<T> {
  Box<T> getBox();

  Future<void> addItemsToBox({required Map<String, T> items}) async {
    items.entries
        .forEach((element) => getBox().put(element.key, element.value));
  }

  Future<void> addItemToBox({required T item, required String key}) async =>
      getBox().put(key, item);

  Future<void> resetBox() async {
    await getBox()
      ..deleteAll(getBox().keys)
      ..clear();
  }

  List<T> getAllItems() {
    return getBox().keys.map((e) => getBox().get(e)).whereType<T>().toList();
  }

  List<T> getItemsByKeys(List<String> keys) {
    return getBox()
        .keys
        .where((element) => keys.contains(element))
        .map((e) => getBox().get(e))
        .whereType<T>()
        .toList();
  }

  T? getItem(String key) => getBox().get(key);

  Future<void> deleteItemsByKeys(List<String> keys) => getBox().deleteAll(keys);

  Future<void> deleteItemByKey(String key) => getBox().delete(key);

  T getItemOrDefault({required String key, required T defaultValue}) =>
      getBox().get(key) ?? defaultValue;
}
