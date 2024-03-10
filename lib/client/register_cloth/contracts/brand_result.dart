class BrandResult {
  final String name;
  final String brandAvatar;

  BrandResult(
    this.name,
    this.brandAvatar,
  );

  factory BrandResult.fromJson(Map<String, dynamic> json) {
    return BrandResult(
      json['name'],
      json['brandAvatar'],
    );
  }
}
