import 'package:beat_ecoprove/core/locales/locale_context.dart';

enum Gender implements Comparable<Gender> {
  male(value: 'male'),
  female(value: 'female'),
  other(value: 'other'),
  notDefine(value: 'notDefine');

  final String value;

  const Gender({required this.value});

  String get displayValue {
    final locale = LocaleContext.get();
    return switch (this) {
      Gender.male => locale.gender_male,
      Gender.female => locale.gender_female,
      Gender.other => locale.gender_other,
      Gender.notDefine => locale.gender_not_define,
    };
  }

  static Gender getOf(String value) =>
      Gender.values.singleWhere((element) => element.displayValue == value);

  static List<Gender> getAllTypes() {
    return Gender.values.toList(); //.map((e) => e.displayValue)
  }

  @override
  toString() => displayValue;

  @override
  int compareTo(Gender other) {
    throw UnimplementedError();
  }
}
