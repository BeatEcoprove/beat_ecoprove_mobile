import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocaleContext {
  static late BuildContext context;

  static setContext(BuildContext newContext) => context = newContext;

  static String getCurrentLocaleString() {
    return Platform.localeName.replaceAll("_", "-");
  }

  static AppLocalizations get() {
    return AppLocalizations.of(context)!;
  }
}
