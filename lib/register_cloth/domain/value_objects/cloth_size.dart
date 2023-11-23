enum ClothSize implements Comparable<ClothSize> {
  xs(value: "XS"),
  s(value: "S"),
  m(value: "M"),
  l(value: "L"),
  xl(value: "XL"),
  xxl(value: "XXL");

  final String value;

  const ClothSize({required this.value});

  static ClothSize getOf(String value) =>
      ClothSize.values.singleWhere((element) => element.value == value);

  static List<String> getAllTypes() {
    return ClothSize.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(ClothSize other) {
    throw UnimplementedError();
  }
}
