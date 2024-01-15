enum Gender implements Comparable<Gender> {
  male(displayValue: "Masculino", value: 'male'),
  female(displayValue: "Feminino", value: 'female'),
  other(displayValue: "Outro", value: 'other'),
  notDefine(displayValue: "Prefiro não divulgar", value: 'notDefine');

  final String value;
  final String displayValue;

  const Gender({required this.value, required this.displayValue});

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
