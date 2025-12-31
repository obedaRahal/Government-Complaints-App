// import 'package:flutter/material.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// import '../../../../core/services/feature_tour/feature_tour_service.dart';
// import 'home_tour_targets.dart';
// import 'home_tour_keys.dart';

// class HomeTourRunner {
//   HomeTourRunner(this._tourService);

//   final FeatureTourService _tourService;

//   /// userKey: يفضّل userId، أو email بعد sanitize
//   void tryShow(BuildContext context, {required String userKey}) {
//     final cacheKey = _cacheKeyForUser(userKey);

//     // ✅ إذا تم عرض الجولة لهذا المستخدم سابقاً لا تعرضها
//     if (_tourService.isTourDone(cacheKey)) return;

//     // ✅ لازم بعد أول frame حتى تكون عناصر الـUI انبنت وصارت الـkeys جاهزة
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       // تأخير بسيط (مفيد إذا عندك Bloc / animations)
//       await Future.delayed(const Duration(milliseconds: 250));

//       // ✅ تحقق أن مفاتيح العناصر موجودة فعلاً
//       final addOk = HomeTourKeys.addComplaintKey.currentContext != null;
//       final notiOk = HomeTourKeys.notificationsKey.currentContext != null;
//       final setOk = HomeTourKeys.settingsKey.currentContext != null;

//       debugPrint('Tour keys ready? add=$addOk noti=$notiOk settings=$setOk');

//       // إذا ولا مفتاح جاهز، لا تعرض الجولة حتى ما تتصرف بغرابة
//       if (!addOk && !notiOk && !setOk) return;

//       // ✅ ابنِ Targets
//       final targets = HomeTourTargets.build(context);

//       // ✅ اعرض الجولة
//       TutorialCoachMark(
//         targets: targets,
//         pulseEnable: true,
//         hideSkip: false,

//         // (اختياري) لون التعتيم (اتركه افتراضي لو ما بدك)
//         // colorShadow: Colors.black,

//         onFinish: () {
//           _tourService.markTourDone(cacheKey);
//           debugPrint('TOUR FINISHED -> saved done ($cacheKey)');
//         },

//         // onSkip نوعها bool Function() في نسختك، لذلك بدون async
//         onSkip: () {
//           _tourService.markTourDone(cacheKey);
//           debugPrint('TOUR SKIPPED -> saved done ($cacheKey)');
//           return true;
//         },
//       ).show(context: context);
//     });
//   }

//   /// مفتاح التخزين لكل مستخدم
//   // String _cacheKeyForUser(String userKey) => 'home_tour_done_$userKey';
//   String _cacheKeyForUser(String userKey) =>
//     'home_tour_done_${_safeKey(userKey)}';

// String _safeKey(String input) =>
//     input.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

// }
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../core/services/feature_tour/feature_tour_service.dart';
import 'home_tour_targets.dart';
import 'home_tour_keys.dart';

class HomeTourRunner {
  HomeTourRunner(this._tourService);

  final FeatureTourService _tourService;

  void tryShow(BuildContext context, {required String userKey}) {
    final cacheKey = 'home_tour_done_${_safeKey(userKey)}';

    if (_tourService.isTourDone(cacheKey)) return;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 250));

      final addOk = HomeTourKeys.addComplaintKey.currentContext != null;
      final notiOk = HomeTourKeys.notificationsKey.currentContext != null;
      final setOk  = HomeTourKeys.settingsKey.currentContext != null;

      debugPrint('Tour keys ready? add=$addOk noti=$notiOk settings=$setOk');

      if (!addOk && !notiOk && !setOk) return;

      late TutorialCoachMark coachMark;

      final targets = HomeTourTargets.build(
        context,
        onNext: () => coachMark.next(),
        onFinish: () {
          coachMark.finish();
          _tourService.markTourDone(cacheKey);
        },
      );

      coachMark = TutorialCoachMark(
        targets: targets,
        pulseEnable: true,
        hideSkip: false,
        onFinish: () {
          _tourService.markTourDone(cacheKey);
          debugPrint('TOUR FINISHED -> saved done ($cacheKey)');
        },
        onSkip: () {
          _tourService.markTourDone(cacheKey);
          debugPrint('TOUR SKIPPED -> saved done ($cacheKey)');
          return true;
        },
      )..show(context: context);
    });
  }

  String _safeKey(String input) =>
      input.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
}
