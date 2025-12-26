// core/di/service_locator.dart
import 'package:complaints_app/features/settings/presentation/manager/theme_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:complaints_app/features/settings/data/datasources/theme_local_ds.dart';
import 'package:complaints_app/features/settings/data/repositories/theme_repository_impl.dart';
import 'package:complaints_app/features/settings/domain/repositories/theme_repository.dart';
import 'package:complaints_app/features/settings/domain/use_cases/get_theme_mode.dart';
import 'package:complaints_app/features/settings/domain/use_cases/set_theme_mode.dart';

final sl = GetIt.instance;

Future<void> initSl() async {
  // DataSource
  sl.registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDataSource());

  // Repo
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(local: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetThemeModeUseCase(sl()));
  sl.registerLazySingleton(() => SetThemeModeUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => ThemeCubit(
      getThemeMode: sl(),
      setThemeMode: sl(),
    ),
  );
}
