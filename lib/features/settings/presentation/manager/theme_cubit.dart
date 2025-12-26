// features/settings/presentation/cubit/theme_cubit.dart
import 'package:complaints_app/features/settings/domain/use_cases/get_theme_mode.dart';
import 'package:complaints_app/features/settings/domain/use_cases/set_theme_mode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final GetThemeModeUseCase getThemeMode;
  final SetThemeModeUseCase setThemeMode;

  ThemeCubit({
    required this.getThemeMode,
    required this.setThemeMode,
  }) : super(const ThemeState(mode: ThemeMode.system));

  Future<void> load() async {
    final mode = await getThemeMode();
    emit(ThemeState(mode: mode));
  }

  Future<void> change(ThemeMode mode) async {
    emit(ThemeState(mode: mode));
    await setThemeMode(mode);
  }

  Future<void> toggleLightDark() async {
    final next = state.mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await change(next);
  }
}
