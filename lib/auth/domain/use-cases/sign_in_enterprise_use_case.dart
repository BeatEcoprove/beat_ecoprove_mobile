import 'package:beat_ecoprove/auth/contracts/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class SignInEnterpriseUseCase
    implements UseCase<SignInEnterpriseRequest, AuthResult> {
  @override
  AuthResult handle(SignInEnterpriseRequest request) {
    return AuthResult("accessToken", "refreshToken");
  }
}
