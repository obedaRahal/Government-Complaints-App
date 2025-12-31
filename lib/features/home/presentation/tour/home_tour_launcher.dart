import 'package:flutter/material.dart';

import '../../../../core/databases/cache/cache_helper.dart';
import '../../../../core/services/feature_tour/feature_tour_service_impl.dart';
import 'home_tour_runner.dart';

class HomeTourLauncher extends StatefulWidget {
  const HomeTourLauncher({super.key, required this.child});
  final Widget child;

  @override
  State<HomeTourLauncher> createState() => _HomeTourLauncherState();
}

class _HomeTourLauncherState extends State<HomeTourLauncher> {
  late final HomeTourRunner _runner;

  // String _safeKey(String input) =>
  //     input.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

  @override
  void initState() {
    super.initState();
    _runner = HomeTourRunner(FeatureTourServiceImpl());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      // ✅ بدّل 'email' باسم المفتاح الحقيقي عندك إن كان مختلف
      final email = (CacheHelper.getData(key: "user_email") ?? "").toString();
_runner.tryShow(context, userKey: email.isEmpty ? "unknown" : email); // (و Runner يعمل sanitize داخلي)
debugPrint("Read user_email from cache: $email");

    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
