import 'package:complaints_app/core/config/route_name.dart';
import 'package:complaints_app/core/databases/api/dio_consumer.dart';
import 'package:complaints_app/core/databases/api/end_points.dart';
import 'package:complaints_app/core/network/network_info.dart';
import 'package:complaints_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:complaints_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:complaints_app/features/auth/domain/use_cases/foget_password_email_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/register_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/resend_code_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/resend_password_reset_otp_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/verify_forget_password_use_case.dart';
import 'package:complaints_app/features/auth/domain/use_cases/verify_register_use_case.dart';
import 'package:complaints_app/features/auth/presentation/manager/forget%20password%20cubit/forget_password_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/login%20cubit/login_cubit.dart';
import 'package:complaints_app/features/auth/presentation/manager/register%20cubit/register_cubit.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_email_view.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_new_password_view.dart';
import 'package:complaints_app/features/auth/presentation/view/forgot_password_otp_code_view.dart';
import 'package:complaints_app/features/auth/presentation/view/login_view.dart';
import 'package:complaints_app/features/auth/presentation/view/register_view.dart';
import 'package:complaints_app/features/auth/presentation/view/verify_register_view.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/views/splash_view.dart';
import 'package:complaints_app/features/splash%20and%20welcome/presentation/views/welcome_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../features/auth/presentation/manager/verify register/verify_register_cubit.dart';

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
    // 1) Dio + ApiConsumer
    final dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
    final apiConsumer = DioConsumer(dio: dio);

    // 2) NetworkInfo
    final connectionChecker = InternetConnectionChecker.createInstance();
    final networkInfo = NetworkInfoImpl(connectionChecker);

    // 3) RemoteDataSource
    final authRemoteDataSource =
        AuthRemoteDataSourceImpl(apiConsumer: apiConsumer);

    // 4) Repository
    final authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
      networkInfo: networkInfo,
    );

    // 5) UseCase
    final loginUseCase = LoginUseCase(repository:  authRepository);

    // 6) BlocProvider + نفس الـ transition الجميل اللي عندك
    return CustomTransitionPage(
      key: state.pageKey,
      child: BlocProvider(
        create: (_) => LoginCubit(loginUseCase: loginUseCase),
        child: const LoginView(),
      ),
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(
          CurveTween(curve: Curves.easeOutCubic),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  },
),


      // GoRoute(
      //   path: '/loginView',
      //   name: AppRouteRName.loginView,
      //   pageBuilder: (context, state) {
      //     return CustomTransitionPage(
      //       key: state.pageKey,
      //       child: const LoginView(),
      //       transitionDuration: const Duration(milliseconds: 350),
      //       transitionsBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //             final tween = Tween<Offset>(
      //               begin: const Offset(0, 1),
      //               end: Offset.zero,
      //             ).chain(CurveTween(curve: Curves.easeOutCubic));

      //             return SlideTransition(
      //               position: animation.drive(tween),
      //               child: child,
      //             );
      //           },
      //     );
      //   },
      // ),

      // 👇 هنا نعدل Route تبع registerView
      GoRoute(
        path: '/registerView',
        name: AppRouteRName.registerView,
        builder: (context, state) {
          // 1) بناء الطبقات من تحت لفوق

          // Dio + ApiConsumer
          final dio = Dio(
            BaseOptions(
              baseUrl: EndPoints.baseUrl,
              receiveDataWhenStatusError: true,
            ),
          );
          final apiConsumer = DioConsumer(dio: dio);

          // NetworkInfo
          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);

          // RemoteDataSource
          final authRemoteDataSource = AuthRemoteDataSourceImpl(
            apiConsumer: apiConsumer,
          );

          // Repository
          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoteDataSource,
            networkInfo: networkInfo,
          );

          // UseCase
          final registerUseCase = RegisterUseCase(authRepository);

          // 2) نرجع RegisterView داخل BlocProvider
          return BlocProvider(
            create: (_) => RegisterCubit(registerUseCase),
            child: const RegisterView(),
          );
        },
      ),

      // GoRoute(
      //   path: '/registerView',
      //   name: AppRouteRName.registerView,
      //   builder: (context, state) => const RegisterView(),
      // ),
      // GoRoute(
      //   path: '/verifyRegisterView',
      //   name: AppRouteRName.verifyRegisterView,
      //   builder: (context, state) {
      //     final email = state.extra as String;
      //     return VerifyRegisterView(email: email);
      //   },
      // ),
      GoRoute(
        path: '/verifyRegisterView',
        name: AppRouteRName.verifyRegisterView,
        builder: (context, state) {
          final email = state.extra as String;

          // Dio + ApiConsumer + NetworkInfo نفس اللي استخدمته في register
          final dio = Dio(
            BaseOptions(
              baseUrl: EndPoints.baseUrl,
              receiveDataWhenStatusError: true,
            ),
          );
          final apiConsumer = DioConsumer(dio: dio);
          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);

          final authRemoteDataSource = AuthRemoteDataSourceImpl(
            apiConsumer: apiConsumer,
          );

          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoteDataSource,
            networkInfo: networkInfo,
          );

          final verifyUseCase = VerifyRegisterUseCase(authRepository);
          final resendUseCase = ResendCodeUseCase(authRepository);

          return BlocProvider(
            create: (_) => VerifyRegisterCubit(
              email: email,
              verifyRegisterUseCase: verifyUseCase,
              resendCodeUseCase: resendUseCase,
            ),
            child: VerifyRegisterView(
              email: email,
            ), // أو VerifyRegisterView لو عدلته
          );
        },
      ),

      ShellRoute(
        builder: (context, state, child) {
          final dio = Dio(
            BaseOptions(
              baseUrl: EndPoints.baseUrl,
              receiveDataWhenStatusError: true,
            ),
          );
          final apiConsumer = DioConsumer(dio: dio);
          final connectionChecker = InternetConnectionChecker.createInstance();
          final networkInfo = NetworkInfoImpl(connectionChecker);

          final authRemoteDataSource = AuthRemoteDataSourceImpl(
            apiConsumer: apiConsumer,
          );

          final authRepository = AuthRepositoryImpl(
            remoteDataSource: authRemoteDataSource,
            networkInfo: networkInfo,
          );

          final forgetPasswordEmailUseCase = FogretPasswordEmailUseCase(repository: 
            authRepository,
          ); // اسمك انت

          final verifyForgotPasswordOtpUseCase = VerifyForgetPasswordUseCase(repository: 
            authRepository,
          );

          final resendPasswordResetOtpUseCase = ResendPasswordResetOtpUseCase(
            authRepository,
          );

          final resetPasswordUseCase = ResetPasswordUseCase(repository:  authRepository);


          return BlocProvider(
            create: (_) => ForgotPasswordCubit(
              forgetPasswordEmailUseCase: forgetPasswordEmailUseCase,
              verifyForgotPasswordOtpUseCase: verifyForgotPasswordOtpUseCase,
              resendPasswordResetOtpUseCase: resendPasswordResetOtpUseCase,
               resetPasswordUseCase: resetPasswordUseCase,
            ),
            child: child,
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

      // ShellRoute(
      //   builder: (context, state, child) {
      //     return BlocProvider(
      //       create: (_) => ForgotPasswordCubit(),
      //       child: child, // هذا يحتوي كل صفحات الفلّو
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       path: '/forgotPasswordEmailView',
      //       name: AppRouteRName.forgotPasswordEmailView,
      //       builder: (context, state) => const ForgotPasswordEmailView(),
      //     ),
      //     GoRoute(
      //       path: '/forgotPasswordOtpCodeView',
      //       name: AppRouteRName.forgotPasswordOtpCodeView,
      //       builder: (context, state) => const ForgetPasswordOtpCodeView(),
      //     ),
      //     GoRoute(
      //       path: '/forgetPasswordNewPasswordView',
      //       name: AppRouteRName.forgotPasswordNewPasswordView,
      //       builder: (context, state) => const ForgotPasswordNewPasswordView(),
      //     ),
      //   ],

      // ),
    ],
  );
}
