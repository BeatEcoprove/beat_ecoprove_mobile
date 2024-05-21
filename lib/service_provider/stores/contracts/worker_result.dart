class WorkerResult {
  final String id;
  final String name;
  final String email;
  final String type;

  WorkerResult(
    this.id,
    this.name,
    this.email,
    this.type,
  );

  factory WorkerResult.fromJson(Map<String, dynamic> json) {
    return WorkerResult(
      json['id'],
      json['name'],
      json['email'],
      json['type'],
    );
  }
}
