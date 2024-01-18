enum ClothType implements Comparable<ClothType> {
  jeans(value: "Jeans", displayValue: "Calças"),
  jackets(value: "Jackets", displayValue: "Casacos"),
  tshirts(value: "TShirts", displayValue: "T-Shirts"),
  shirts(value: "Shirts", displayValue: "Camisas"),
  skirts(value: "Skirts", displayValue: "Saias");

  final String value;
  final String displayValue;

  const ClothType({required this.value, required this.displayValue});

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
