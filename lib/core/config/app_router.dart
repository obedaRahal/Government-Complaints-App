import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_cubit.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_email_view.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_new_password_view.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_otp_code_view.dart';
import 'package:complaints_app/features/auth/presentation/view/login_view.dart';
import 'package:complaints_app/features/auth/presentation/view/register_view.dart';
import 'package:complaints_app/features/auth/presentation/view/verify_register_view.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/views/splash_view.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/views/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRourer {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/welcomeView',
        name: AppRouteRName.welcomeView,
        builder: (context, state) => const WelcomeView(),
      ),
      GoRoute(
        path: '/loginView',
        name: AppRouteRName.loginView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginView(),
            transitionDuration: const Duration(milliseconds: 350),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final tween = Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeOutCubic));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: '/registerView',
        name: AppRouteRName.registerView,
        builder: (context, state) => const RegisterView(),
      ),

      GoRoute(
        path: '/verifyRegisterView',
        name: AppRouteRName.verifyRegisterView,
        builder: (context, state) => const VerifyRegisterView(),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => ForgotPasswordCubit(),
            child: child, // هذا يحتوي كل صفحات الفلّو
          );
        },
        routes: [
          GoRoute(
            path: '/forgotPasswordEmailView',
            name: AppRouteRName.forgotPasswordEmailView,
            builder: (context, state) => const ForgotPasswordEmailView(),
          ),
          GoRoute(
            path: '/forgotPasswordOtpCodeView',
            name: AppRouteRName.forgotPasswordOtpCodeView,
            builder: (context, state) => const ForgetPasswordOtpCodeView(),
          ),
          GoRoute(
            path: '/forgetPasswordNewPasswordView',
            name: AppRouteRName.forgotPasswordNewPasswordView,
            builder: (context, state) => const ForgotPasswordNewPasswordView(),
          ),
        ],
      ),
    ],
  );
}
