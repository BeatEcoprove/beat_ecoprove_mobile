import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _store;

  static Future initStorage() async {
    Future<SharedPreferences> storeReference = SharedPreferences.getInstance();
    _store = await storeReference;
  }

  static Future<bool> valueExists(String key) async =>
      await getValue("flutter.$key") != null;

  static Future<T> getValue<T>(String key) async {
    return _store.get(key) as T;
  }

  static Future clearValue(String key) async {
    return await _store.remove(key);
  }

  static Future setValue<T>(String key, T value) async {
    _store.setString(key, value.toString());
  }
}
