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
    return StoreResult(
      json['id'],
      json['name'],
      json['numberWorkers'],
      json['country'],
      json['locality'],
      json['street'],
      json['postalCode'],
      json['numberPort'],
      json['sustainablePoints'],
      json['rating'],
      json['picture'],
      json['level'],
    );
  }
}
