class AuthResult {
  final String accessToken;
  final String refreshToken;

  AuthResult(this.accessToken, this.refreshToken);

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return AuthResult(
      json['accessToken'],
      json['refreshToken'],
    );
  }
}
