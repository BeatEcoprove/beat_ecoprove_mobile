enum ClothType implements Comparable<ClothType> {
  //TODO: CHANGE IT
  jeans(value: "Jeans"),
  jackets(value: "Jackets"),
  tshirts(value: "TShirts"),
  shirts(value: "Shirts"),
  skirts(value: "Skirts");

  final String value;

  const ClothType({required this.value});

  static ClothType getOf(String value) =>
      ClothType.values.singleWhere((element) => element.value == value);

  static List<String> getAllTypes() {
    return ClothType.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(ClothType other) {
    throw UnimplementedError();
  }
}
