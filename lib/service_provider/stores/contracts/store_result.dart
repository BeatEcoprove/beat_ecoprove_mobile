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
    dynamic totalRating = json['totalRating'];
    if (totalRating is int) {
      totalRating = totalRating.toDouble();
    }

    return StoreResult(
      json['id'],
      json['name'],
      json['numberOfWorkers'],
      //TODO: ERROR IN API
      // json['address']['country'],
      'Portugal',
      json['address']['locality'],
      json['address']['street'],
      json['address']['postalCode']['value'],
      json['address']['port'],
      json['sustainablePoints'],
      totalRating,
      json['picture'],
      json['level'],
    );
  }
}
