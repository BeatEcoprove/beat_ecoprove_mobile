import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class LoginUseCase implements UseCase<LoginRequest, Future> {
  final AuthenticationService _authenticationService;

  LoginUseCase(this._authenticationService);

  @override
  Future handle(LoginRequest request) async {
    await _authenticationService.login(request.email, request.password);
  }
}
