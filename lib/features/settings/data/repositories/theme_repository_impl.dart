// data/repositories/theme_repository_impl.dart
import 'package:flutter/material.dart';
import 'package:complaints_app/features/settings/data/datasources/theme_local_ds.dart';
import 'package:complaints_app/features/settings/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource local;

  ThemeRepositoryImpl({required this.local});

  @override
  Future<ThemeMode> getMode() => local.readMode();

  @override
  Future<void> setMode(ThemeMode mode) => local.saveMode(mode);
}
