import 'package:complaints_app/core/config/app_router.dart';
import 'package:complaints_app/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ComplaitsApp());
}

class ComplaitsApp extends StatelessWidget {
  const ComplaitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData().copyWith(scaffoldBackgroundColor: AppColor.white),
      routerConfig: AppRourer.router,
    );
  }
}
