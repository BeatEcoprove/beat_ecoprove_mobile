import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:beat_ecoprove/core/locales/l10n/app_localizations.dart';
import 'package:beat_ecoprove/core/locales/l10n/app_localizations_en.dart';

class LocaleContext {
  static BuildContext? _context;
  static AppLocalizations? _localizations;
  static int _retryCount = 0;
  static const maxRetries = 3;
  static const retryDelay = Duration(milliseconds: 100);

  static void initializeContext(BuildContext context) {
    _context = context;
    _retryCount = 0;
    _tryUpdateLocalizations();
  }

  static Future<void> _tryUpdateLocalizations() async {
    if (_context == null) return;

    try {
      final localizations = AppLocalizations.of(_context!);
      if (localizations != null) {
        _localizations = localizations;
        _retryCount = 0;
      } else if (_retryCount < maxRetries) {
        _retryCount++;
        await Future.delayed(retryDelay);
        _tryUpdateLocalizations();
      }
    } catch (_) {
      if (_retryCount < maxRetries) {
        _retryCount++;
        await Future.delayed(retryDelay);
        _tryUpdateLocalizations();
      }
    }
  }

  static String getCurrentLocaleString() {
    try {
      if (_context != null) {
        final locale = Localizations.localeOf(_context!);
        return locale.toString().replaceAll('_', '-');
      }
    } catch (_) {}
    return Platform.localeName.replaceAll("_", "-");
  }

  static AppLocalizations get() {
    if (_localizations != null) {
      return _localizations!;
    }

    if (_context != null) {
      final localizations = AppLocalizations.of(_context!);
      if (localizations != null) {
        _localizations = localizations;
        return localizations;
      }

      if (_retryCount < maxRetries) {
        _retryCount++;
        Future.delayed(retryDelay, () => _tryUpdateLocalizations());
      }

      final lastTry = AppLocalizations.of(_context!);
      if (lastTry != null) {
        _localizations = lastTry;
        return lastTry;
      }
    }

    _localizations = AppLocalizationsEn();
    return _localizations!;
  }
}
