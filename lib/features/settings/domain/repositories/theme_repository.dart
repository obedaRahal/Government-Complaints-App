// domain/repositories/theme_repository.dart
import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<ThemeMode> getMode();
  Future<void> setMode(ThemeMode mode);
}
