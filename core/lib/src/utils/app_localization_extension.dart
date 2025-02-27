import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';

extension AppLocalizationExtension on BuildContext {
  AppLocalizations get locale {
    return AppLocalizations.of(this)!;
  }
}
