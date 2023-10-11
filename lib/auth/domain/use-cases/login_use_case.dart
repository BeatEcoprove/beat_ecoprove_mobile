import 'package:beat_ecoprove/auth/contracts/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class LoginUseCase extends UseCase<LoginRequest, Future<AuthResult>> {
  final AuthenticationService _authenticationService;

  LoginUseCase({required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  @override
  Future<AuthResult> handle(LoginRequest request) async {
    await _authenticationService.login(request.email, request.password);

    return AuthResult("", "");
  }
}
