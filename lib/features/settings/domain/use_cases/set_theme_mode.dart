// domain/usecases/set_theme_mode.dart
import 'package:flutter/material.dart';
import '../repositories/theme_repository.dart';

class SetThemeModeUseCase {
  final ThemeRepository repo;
  SetThemeModeUseCase(this.repo);

  Future<void> call(ThemeMode mode) => repo.setMode(mode);
}
