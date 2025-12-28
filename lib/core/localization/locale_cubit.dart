// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LocaleCubit extends Cubit<Locale> {
//   LocaleCubit({Locale? initialLocale})
//       : super(initialLocale ?? const Locale('ar'));

//   static const supportedLocales = <Locale>[
//     Locale('ar'),
//     Locale('en'),
//   ];

//   bool get isArabic => state.languageCode == 'ar';

//   void setArabic() => emit(const Locale('ar'));
//   void setEnglish() => emit(const Locale('en'));

//   void toggle() {
//     if (isArabic) {
//       setEnglish();
//     } else {
//       setArabic();
//     }
//   }

//   void setLocale(Locale locale) {
//     final isSupported = supportedLocales.any(
//       (l) => l.languageCode == locale.languageCode,
//     );
//     if (isSupported) emit(locale);
//   }
// }
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../databases/cache/cache_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  static const _localeKey = 'app_locale';

  LocaleCubit({Locale? initialLocale})
      : super(initialLocale ?? const Locale('ar'));

  static const supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  bool get isArabic => state.languageCode == 'ar';

  // ✅ احفظ اللغة في الكاش
  Future<void> _saveLocale(String code) async {
    await CacheHelper.saveData(key: _localeKey, value: code);
  }

  // ✅ استرجاع اللغة المحفوظة (نستعملها من main)
  static Locale loadSavedLocale() {
    final code = CacheHelper.getData(key: _localeKey);
    if (code == 'en') return const Locale('en');
    return const Locale('ar');
  }

  Future<void> setArabic() async {
    emit(const Locale('ar'));
    await _saveLocale('ar');
  }

  Future<void> setEnglish() async {
    emit(const Locale('en'));
    await _saveLocale('en');
  }

  Future<void> toggle() async {
    if (isArabic) {
      await setEnglish();
    } else {
      await setArabic();
    }
  }

  Future<void> setLocale(Locale locale) async {
    final isSupported = supportedLocales.any(
      (l) => l.languageCode == locale.languageCode,
    );
    if (!isSupported) return;

    emit(locale);
    await _saveLocale(locale.languageCode);
  }
}
