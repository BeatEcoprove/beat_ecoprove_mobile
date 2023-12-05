class BrandResult {
  final String name;

  BrandResult(
    this.name,
  );

  factory BrandResult.fromJson(Map<String, dynamic> json) {
    return BrandResult(
      json['name'],
    );
  }
}
