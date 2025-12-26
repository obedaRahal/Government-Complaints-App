// domain/usecases/get_theme_mode.dart
import 'package:flutter/material.dart';
import '../repositories/theme_repository.dart';

class GetThemeModeUseCase {
  final ThemeRepository repo;
  GetThemeModeUseCase(this.repo);

  Future<ThemeMode> call() => repo.getMode();
}
