// data/datasources/theme_local_ds.dart
import 'package:flutter/material.dart';
import 'package:complaints_app/core/databases/cache/cache_helper.dart';

class ThemeLocalDataSource {
  static const _key = 'theme_mode'; // system/light/dark

  Future<void> saveMode(ThemeMode mode) async {
    await CacheHelper.saveData(key: _key, value: mode.name);
  }

  Future<ThemeMode> readMode() async {
    final v = CacheHelper.getData(key: _key) as String?;
    final name = v ?? ThemeMode.system.name;

    return ThemeMode.values.firstWhere(
      (e) => e.name == name,
      orElse: () => ThemeMode.system,
    );
  }
}
