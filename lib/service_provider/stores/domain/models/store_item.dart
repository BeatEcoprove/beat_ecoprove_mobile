class StoreItem {
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

  StoreItem({
    required this.id,
    required this.name,
    required this.numberWorkers,
    required this.country,
    required this.locality,
    required this.street,
    required this.postalCode,
    required this.numberPort,
    required this.sustainablePoints,
    required this.rating,
    required this.picture,
    required this.level,
  });
}
