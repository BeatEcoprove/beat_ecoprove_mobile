import 'package:beat_ecoprove/core/locales/locale_context.dart';

enum GroupType implements Comparable<GroupType> {
  public(value: 'public'),
  private(value: 'private');

  final String value;

  const GroupType({required this.value});

  String get displayValue {
    final locale = LocaleContext.get();
    return switch (this) {
      GroupType.public => locale.group_domain_type_public,
      GroupType.private => locale.group_domain_type_private,
    };
  }

  static GroupType getOf(String value) =>
      GroupType.values.singleWhere((element) => element.value == value);

  static GroupType getOfDisplayValue(String value) =>
      GroupType.values.singleWhere((element) => element.displayValue == value);

  static List<GroupType> getAllTypes() {
    return GroupType.values.toList();
  }

  @override
  String toString() => displayValue;

  @override
  int compareTo(GroupType other) {
    throw UnimplementedError();
  }
}
