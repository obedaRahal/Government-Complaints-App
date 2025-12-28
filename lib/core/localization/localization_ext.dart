import 'package:complaints_app/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension LocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
