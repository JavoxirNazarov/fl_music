import 'package:hive_flutter/hive_flutter.dart';
import 'package:top_music/common/libs/store_manager/store_manager.dart';

const sessionBoxName = 'sessionBox';

class SessionStore {
  static Future<Box<dynamic>> init() async {
    return Hive.openBox<String>(sessionBoxName);
  }

  SessionStore();

  final _store = StoreManager<String>(box: Hive.box(sessionBoxName));

  String? getSession() => _store.getValue('session');

  void removeSession() => _store.removeValue('session');

  void setSession(String token) => _store.addValue('session', token);
}
