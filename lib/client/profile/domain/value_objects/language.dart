import 'package:beat_ecoprove/core/locales/locale_context.dart';

enum Language implements Comparable<Language> {
  pt(value: 'pt'),
  en(value: 'en');

  final String value;

  const Language({required this.value});

  String get displayValue {
    final locale = LocaleContext.get();
    return switch (this) {
      Language.pt => locale.language_pt,
      Language.en => locale.language_en,
    };
  }

  static Language getOf(String value) =>
      Language.values.singleWhere((element) => element.value == value);

  static Language getOfDisplayValue(String value) =>
      Language.values.singleWhere((element) => element.displayValue == value);

  static List<Language> getAllLanguages() {
    return Language.values.toList();
  }

  @override
  String toString() => displayValue;

  @override
  int compareTo(Language other) {
    throw UnimplementedError();
  }
}
