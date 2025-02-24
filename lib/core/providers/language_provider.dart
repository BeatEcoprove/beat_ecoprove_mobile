import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageProvider extends ChangeNotifier {
  static const String sharedPreferencesLanguage = 'languageCode';

  final BehaviorSubject<Locale> _localeSubject =
      BehaviorSubject<Locale>.seeded(const Locale('en'));

  Stream<Locale> get localeStream => _localeSubject.stream;
  Locale get currentLocale => _localeSubject.value;

  Future<void> deviceLanguage() async {
    Locale deviceLocale = Locale(Platform.localeName.split('_')[0]);
    Locale defaultLocale =
        AppLocalizations.supportedLocales.contains(deviceLocale)
            ? deviceLocale
            : const Locale('en');

    _localeSubject.add(defaultLocale);
  }

  Future<void> initializeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(sharedPreferencesLanguage);

    if (languageCode != null) {
      _localeSubject.add(Locale(languageCode));
    } else {
      deviceLanguage();
    }
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(sharedPreferencesLanguage, languageCode);
  }

  Future<void> changeLanguage(String languageCode) async {
    await _saveLanguage(languageCode);
    _localeSubject.add(Locale(languageCode));
  }

  @override
  void dispose() {
    _localeSubject.close();
    super.dispose();
  }
}
