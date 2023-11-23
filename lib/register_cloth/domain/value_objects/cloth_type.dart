enum ClothType implements Comparable<ClothType> {
  jeans(value: "Calças"),
  jackets(value: "Casacos"),
  tShirts(value: "T-shirts"),
  shirts(value: "Camisas"),
  skirts(value: "Saias");

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
