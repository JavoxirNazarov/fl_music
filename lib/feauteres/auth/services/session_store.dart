import 'package:hive_flutter/hive_flutter.dart';
import 'package:top_music/common/libs/store_manager/store_manager.dart';

class SessionStore {
  const SessionStore._();

  static get intance => const SessionStore._();

  static Future<Box<dynamic>> init() async {
    return Hive.openBox('sessionBox');
  }

  final StoreManager _store = const StoreManager();

  String? getSession() {
    return _store.getValue('sessionBox', 'session');
  }

  void removeSession() {
    _store.removeValue('sessionBox', 'session');
  }

  void addSession(String token) {
    _store.addValue('sessionBox', 'session', token);
  }
}
