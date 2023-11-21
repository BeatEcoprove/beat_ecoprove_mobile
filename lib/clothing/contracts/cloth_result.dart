class ClothResult {
  final String id;
  final String name;
  final String type;
  final String size;
  final String brand;
  final String color;
  final int ecoScore;
  final String clothAvatar;

  ClothResult(
    this.id,
    this.name,
    this.type,
    this.size,
    this.brand,
    this.color,
    this.ecoScore,
    this.clothAvatar,
  );

  factory ClothResult.fromJson(Map<String, dynamic> json) {
    return ClothResult(
      json['id'],
      json['name'],
      json['type'],
      json['size'],
      json['brand'],
      json['color'],
      json['ecoScore'],
      json['clothAvatar'],
    );
  }
}
