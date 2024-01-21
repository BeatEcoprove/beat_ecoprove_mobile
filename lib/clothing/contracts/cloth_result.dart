class ClothResult {
  final String id;
  final String name;
  final String type;
  final String state;
  final String size;
  final String brand;
  final String color;
  final int ecoScore;
  final ClothStates clothState;
  final String clothAvatar;
  final String otherProfileAvatar;

  ClothResult(
    this.id,
    this.name,
    this.type,
    this.state,
    this.size,
    this.brand,
    this.color,
    this.ecoScore,
    this.clothState,
    this.clothAvatar,
    this.otherProfileAvatar,
  );

  factory ClothResult.fromJson(Map<String, dynamic> json) {
    return ClothResult(
      json['id'],
      json['name'],
      json['type'],
      json['clothState'],
      json['size'],
      json['brand'],
      json['color'],
      json['ecoScore'],
      ClothStates.getOf(json['clothState']),
      json['clothAvatar'],
      json['profile']['avatarUrl'],
    );
  }
}

enum ClothStates implements Comparable<ClothStates> {
  idle(value: "Idle"),
  inUse(value: "InUse"),
  blocked(value: "Blocked");

  final String value;

  const ClothStates({required this.value});

  static ClothStates getOf(String value) =>
      ClothStates.values.singleWhere((element) => element.value == value);

  static List<String> getAllTypes() {
    return ClothStates.values.map((e) => e.value).toList();
  }

  @override
  int compareTo(ClothStates other) {
    throw UnimplementedError();
  }
}
