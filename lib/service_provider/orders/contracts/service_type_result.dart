class ServiceTypeResult {
  final String id;
  final String name;
  final String badge;
  // final String type;

  ServiceTypeResult(
    this.id,
    this.name,
    this.badge,
    // this.type,
  );

  factory ServiceTypeResult.fromJson(Map<String, dynamic> json) {
    return ServiceTypeResult(
      json['id'],
      json['name'],
      json['badge'],
      // json['type'],
    );
  }
}
