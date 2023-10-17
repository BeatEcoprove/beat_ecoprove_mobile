class PostalCode {
  final String value;

  PostalCode._({required this.value});

  factory PostalCode.create(String postalCode) {
    return PostalCode._(value: postalCode);
  }

  @override
  String toString() {
    return value;
  }
}
