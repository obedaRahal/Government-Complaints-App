import 'package:complaints_app/core/config/app_router.dart';
import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/databases/cache/cache_helper.dart';
import 'package:complaints_app/core/di/service_locator.dart';
import 'package:complaints_app/core/services/notification/local_votification_service.dart';
import 'package:complaints_app/core/services/notification/push_notification_service.dart';
import 'package:complaints_app/core/theme/theme/app_theme.dart';
import 'package:complaints_app/core/utils/auth_session.dart';
import 'package:complaints_app/features/settings/presentation/manager/theme_cubit.dart';
import 'package:complaints_app/features/settings/presentation/manager/theme_state.dart';
import 'package:complaints_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  debugPrint('📩 BG title: ${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // await CacheHelper.clearData();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Future.wait([
    PushNotificationService.init(),
    LocalNotificationService.init(),
  ]);

  await initSl();

  runApp(
    BlocProvider<ThemeCubit>(
      create: (_) => sl<ThemeCubit>()..load(),
      child: const ComplaitsApp(),
    ),
  );
}

//======================= Hi 👀 ============================
class ComplaitsApp extends StatefulWidget {
  const ComplaitsApp({super.key});

  @override
  State<ComplaitsApp> createState() => _ComplaitsAppState();
}

class _ComplaitsAppState extends State<ComplaitsApp> {
  @override
  void initState() {
    super.initState();
    AuthSession.instance.isAuthenticated.addListener(_onAuthChanged);
  }

  void _onAuthChanged() {
    final isAuth = AuthSession.instance.isAuthenticated.value;
    if (!isAuth) {
      AppRourer.router.goNamed(AppRouteRName.loginView);
    }
  }

  @override
  void dispose() {
    AuthSession.instance.isAuthenticated.removeListener(_onAuthChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: state.mode,
          //theme: ThemeData().copyWith(scaffoldBackgroundColor: AppColor.white),
          routerConfig: AppRourer.router,
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
        );
      },
    );
  }
}
