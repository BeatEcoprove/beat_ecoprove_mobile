class ErrorResponse {
  final String type;
  final String title;
  final int status;

  ErrorResponse(this.type, this.title, this.status);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      json['type'],
      json['title'],
      json['status'],
    );
  }
}
