import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/views/splash_view.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/views/welcome_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRourer {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: AppRouteRName.welcomeView, builder: (context, state) => const WelcomeView()),
    ],
  );
}

