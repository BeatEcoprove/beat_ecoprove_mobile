import 'package:beat_ecoprove/auth/contracts/auth_result.dart';

class AuthenticationService {
  Future<AuthResult> login(String email, String password) {
    return Future.delayed(
      const Duration(seconds: 15),
      () {
        return AuthResult("accessToken", "refreshToken");
      },
    );
  }
}
