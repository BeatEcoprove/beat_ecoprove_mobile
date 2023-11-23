enum ClothBrand implements Comparable<ClothBrand> {
  salsa(value: "Salsa"),
  nike(value: "Nike"),
  adidas(value: "Adidas"),
  hem(value: "H&M"),
  tiffosi(value: "Tiffosi"),
  mo(value: "MO"),
  lacoste(value: "Lacoste");

  final String value;

  const ClothBrand({required this.value});

  static ClothBrand getOf(String value) =>
      ClothBrand.values.singleWhere((element) => element.value == value);

  static List<String> getAllTypes() {
    return ClothBrand.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(ClothBrand other) {
    throw UnimplementedError();
  }
}
