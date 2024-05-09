class DetailErrorResponse extends ErrorResponse {
  DetailErrorResponse(
    super.type,
    super.title,
    super.status,
  );

  factory DetailErrorResponse.fromJson(Map<String, dynamic> json) {
    var {
      "type": type,
      "status": status,
      "errors": errors,
    } = json;

    return DetailErrorResponse(
      type,
      errors.values.first.first,
      status,
    );
  }
}

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
