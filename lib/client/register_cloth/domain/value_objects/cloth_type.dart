import 'package:beat_ecoprove/core/locales/locale_context.dart';

enum ClothType implements Comparable<ClothType> {
  jeans(value: "Jeans"),
  jackets(value: "Jackets"),
  tshirts(value: "TShirts"),
  shirts(value: "Shirts"),
  skirts(value: "Skirts");

  final String value;

  const ClothType({required this.value});

  String get displayValue {
    final locale = LocaleContext.get();
    return switch (this) {
      ClothType.jeans => locale.client_clothing_domain_data_filters_jeans,
      ClothType.jackets => locale.client_clothing_domain_data_filters_jackets,
      ClothType.tshirts => locale.client_clothing_domain_data_filters_t_shirts,
      ClothType.shirts => locale.client_clothing_domain_data_filters_shirts,
      ClothType.skirts => locale.client_clothing_domain_data_filters_skirts,
    };
  }

  static ClothType getOf(String value) =>
      ClothType.values.singleWhere((element) => element.displayValue == value);

  static List<ClothType> getAllTypes() {
    return ClothType.values.toList();
  }

  @override
  toString() => displayValue;

  @override
  int compareTo(ClothType other) {
    throw UnimplementedError();
  }
}
