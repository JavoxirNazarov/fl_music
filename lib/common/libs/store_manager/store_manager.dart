import 'package:hive_flutter/hive_flutter.dart';

class StoreManager<T> {
  static Future<void> init() async {
    return Hive.initFlutter();
  }

  const StoreManager({required this.box});

  final Box<T> box;

  void addValue(String key, T value) {
    box.put(key, value);
  }

  T? getValue(String key) {
    return box.get(key);
  }

  void removeValue(String key) {
    box.delete(key);
  }
}
