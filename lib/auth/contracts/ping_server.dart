class PingServerResult {
  final String message;

  PingServerResult._(this.message);

  factory PingServerResult.fromJson(Map<String, dynamic> json) {
    return PingServerResult._(json['message']);
  }
}
