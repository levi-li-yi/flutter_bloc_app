import 'package:sqflite/sqflite.dart';

class SettingDateProvider {
  Database conn;

  SettingDateProvider(this.conn);

  final _settings = <String, String>{};
  final _listeners =
      <Function(SettingDateProvider settings, String key, String value)>[];

  // 获取设置数据
  Future<void> loadSettings() async {
    List<Map<String, Object?>> kvs = await conn.query('settings');
    // 先清理数据
    _settings.clear();

    for (var kv in kvs) {
      _settings[kv['key'] as String] = kv['value'] as String;
    }

    void listen(
      Function(SettingDateProvider settings, String key, String value) listener,
    ) {
      _listeners.add(listener);
    }

    // 设置数据
    Future<void> set(String key, String value) async {
      _settings[key] = value;

      final kvs =
          await conn.query('settings', where: 'key = ?', whereArgs: [key]);

      if (kvs.isEmpty) {
        await conn.insert('settings', {'key': key, 'value': value});
      } else {
        await conn.update('settings', {'value': value},
            where: 'key = ?', whereArgs: [key]);
      }

      for (var f in _listeners) {
        f(this, key, value);
      }
    }

    // 获取设置数据的某个字段
    String? get(String key) {
      return _settings[key];
    }

    // 获取吗，默认设置数据
    String getDefault(String key, String defalutValue) {
      return _settings[key] ?? defalutValue;
    }

    int getDefaultInt(String key, int defaultValue) {
      return int.tryParse(_settings[key] ?? '') ?? defaultValue;
    }

    bool getDefaultBool(String key, bool defaultValue) {
      return _settings[key] == 'true' ? true : defaultValue;
    }

    double getDefaultDouble(String key, double defaultValue) {
      return double.tryParse(_settings[key] ?? '') ?? defaultValue;
    }
  }
}
