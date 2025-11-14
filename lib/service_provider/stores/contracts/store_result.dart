class StoreResult {
  final String id;
  final String name;
  final int numberWorkers;
  final String country;
  final String locality;
  final String street;
  final String postalCode;
  final String numberPort;
  final int sustainablePoints;
  final double rating;
  final String picture;
  final int level;

  StoreResult(
    this.id,
    this.name,
    this.numberWorkers,
    this.country,
    this.locality,
    this.street,
    this.postalCode,
    this.numberPort,
    this.sustainablePoints,
    this.rating,
    this.picture,
    this.level,
  );

  factory StoreResult.fromJson(Map<String, dynamic> json) {
    dynamic totalRating = json['total_rating'] ?? 0;
    if (totalRating is int) {
      totalRating = totalRating.toDouble();
    }

    return StoreResult(
      json['id'] ?? '',
      json['name'] ?? '',
      json['number_of_workers'] ?? 0,
      //TODO: ERROR IN API
      // json['address']['country'],
      'Portugal',
      json['address']['locality'] ?? '',
      json['address']['street'] ?? '',
      json['address']['zip_code']['value'] ?? '',
      json['address']['port'] ?? '',
      json['sustainable_points'] ?? 0,
      totalRating,
      json['picture'] ?? '',
      json['level'] ?? 0,
    );
  }
}
