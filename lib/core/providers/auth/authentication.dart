import 'package:beat_ecoprove/core/domain/entities/user.dart';

class Authentication {
  final String accessToken;
  final String refreshToken;
  final User user;

  Authentication(
      {required this.accessToken,
      required this.refreshToken,
      required this.user});

  Authentication.bare(
      {this.accessToken = "", required this.refreshToken, required this.user});
}
