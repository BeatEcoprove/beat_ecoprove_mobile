enum Gender implements Comparable<Gender> {
  male(value: "Masculino"),
  female(value: "Feminino"),
  other(value: "Outro"),
  notDefine(value: "Prefiro não divulgar");

  final String value;

  const Gender({required this.value});

  static Gender getOf(String value) =>
      Gender.values.singleWhere((element) => element.value == value);

  static List<String> getAllTypes() {
    return Gender.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(Gender other) {
    throw UnimplementedError();
  }
}
