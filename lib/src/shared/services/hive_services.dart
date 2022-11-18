import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveService<K, T> {
  Box<T> getBox();

  Future<void> addItemsToBox({required Map<K, T> items}) async {
    items.entries
        .forEach((element) => getBox().put(element.key, element.value));
  }

  Future<void> addItemToBox({required T item, required K key}) async =>
      getBox().put(key, item);

  Future<void> resetBox() async {
    await getBox()
      ..deleteAll(getBox().keys)
      ..clear();
  }

  List<T> getAllItems() {
    return getBox().keys.map((e) => getBox().get(e)).whereType<T>().toList();
  }

  List<T> getItemsByKeys(List<K> keys) {
    return getBox()
        .keys
        .where((element) => keys.contains(element))
        .map((e) => getBox().get(e))
        .whereType<T>()
        .toList();
  }

  T? getItem(K key) => getBox().get(key);

  Future<void> deleteItemsByKeys(List<K> keys) => getBox().deleteAll(keys);

  Future<void> deleteItemByKey(K key) => getBox().delete(key);

  T getItemOrDefault({required K key, required T defaultValue}) =>
      getBox().get(key) ?? defaultValue;
}
