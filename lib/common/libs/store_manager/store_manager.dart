import 'package:hive_flutter/hive_flutter.dart';

class StoreManager {
  const StoreManager();

  static Future<void> init() async {
    return Hive.initFlutter();
  }

  void addValue(String storeName, String key, String value) {
    Hive.box(storeName).put(key, value);
  }

  String? getValue(String storeName, String key) {
    return Hive.box(storeName).get(
      key,
    );
  }

  void removeValue(String storeName, String key) {
    Hive.box(storeName).delete(
      key,
    );
  }
}
