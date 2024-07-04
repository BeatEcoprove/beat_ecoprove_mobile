class ServiceProviderResult {
  final String id;
  final String name;
  final String type;
  final String icon;

  ServiceProviderResult(
    this.id,
    this.name,
    this.type,
    this.icon,
  );

  factory ServiceProviderResult.fromJson(Map<String, dynamic> json) {
    return ServiceProviderResult(
      json['id'],
      json['title'],
      json['type'],
      json['picture'],
    );
  }
}
