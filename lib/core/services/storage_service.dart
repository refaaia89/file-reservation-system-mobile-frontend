import 'package:internet_application/core/services/log_service.dart';
import 'package:internet_application/core/services/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final logger = locator<LogService>();

  static late SharedPreferences _preferences;

  StorageService({var preferences}) {
    logger.i("LocalStorageService(): init fun");
    _preferences = preferences;
  }

  // updated _saveToDisk function that handles all types
  Future<void> saveToDisk<T>(String key, T content) async {
    logger.log.i('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content \n ${content.runtimeType}');

    if (content is String) {
      await _preferences.setString(key, content);
    }
    if (content is bool) {
      await _preferences.setBool(key, content);
    }
    if (content is int) {
      await _preferences.setInt(key, content);
    }
    if (content is double) {
      await _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      await _preferences.setStringList(key, content);
    }
  }

  // updated _saveToDisk function that handles all types
  Future<bool> removeFromDisk<T>(String key) {
    logger.log.i('(TRACE) LocalStorageService:Remove from desk. key: $key');

    return _preferences.remove(key);
  }

  dynamic getFromDisk(String key) {
    var value = _preferences.get(key);
    logger.log.i('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  Future<bool> clearStorage() {
    logger.log.i('(TRACE) LocalStorageService:clearStorage');
    return _preferences.clear();
  }
}
