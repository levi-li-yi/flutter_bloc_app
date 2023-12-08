/*
 * @Author: Levi Li
 * @Date: 2023-12-08 18:46:05
 * @description: 
 */
import 'package:sqflite/sqflite.dart';

// 公共的数据缓存数据库方法
class CacheDataProvider {
  Database conn;

  CacheDataProvider(this.conn);

  // 设置缓存
  Future<void> set(
    String key,
    String value,
    Duration ttl, {
    String? group,
  }) async {
    await conn.delete('cache', where: 'key = ?', whereArgs: [key]);
    await conn.insert('cache', <String, Object?>{
      'key': key,
      'value': value,
      'group': group,
      'create_at': DateTime.now().millisecondsSinceEpoch,
      'valid_before': DateTime.now().add(ttl).millisecondsSinceEpoch,
    });
  }

  // 查询group下所有缓存
  Future<Map<String, String>> getAllInGroup(String group) async {
    List<Map<String, Object?>> cacheValue = await conn.query(
      'cahce',
      where: '`group` = ? AND valid_before >= ?',
      whereArgs: [group, DateTime.now().millisecondsSinceEpoch],
    );
    if (cacheValue.isEmpty) {
      return {};
    }

    Map<String, String> ret = {};

    for (var item in cacheValue) {
      ret[item['key'] as String] = item['value'] as String;
    }
    return ret;
  }

  // 查询某个key对应的缓存数据
  Future<String?> get(String key) async {
    List<Map<String, Object?>> cacheValue = await conn.query('cache',
        where: 'key = ? AND valid_before >= ?',
        whereArgs: [key, DateTime.now().millisecondsSinceEpoch],
        limit: 1);

    if (cacheValue.isEmpty) {
      return null;
    }
    return cacheValue.first['value'] as String;
  }

  // 删除某个key对应的缓存
  Future<void> remove(String key) async {
    await conn.delete('cache', where: 'key = ?', whereArgs: [key]);
  }

  // 清理过期的keys
  Future<void> gc() async {
    await conn.delete(
      'cache',
      where: 'valid_before < ?',
      whereArgs: [DateTime.now().millisecondsSinceEpoch],
    );
  }

  // 清空所有缓存
  Future<void> clearAll() async {
    await conn.delete('cache');
  }
}
