import 'package:beat_ecoprove/auth/contracts/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in_personal_request.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class SignInPersonalUseCase
    implements UseCase<SignInPersonalRequest, AuthResult> {
  @override
  AuthResult handle(SignInPersonalRequest request) {
    return AuthResult("accessToken", "refreshToken");
  }
}
