class ColorResult {
  final String name;
  final String hex;

  ColorResult(
    this.name,
    this.hex,
  );

  factory ColorResult.fromJson(Map<String, dynamic> json) {
    return ColorResult(
      json['name'],
      json['hex'],
    );
  }
}
