import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class SignInEnterpriseUseCase
    implements UseCase<SignInEnterpriseRequest, Future> {
  final AuthenticationProvider _authProvider;
  final AuthenticationService _authenticationService;

  SignInEnterpriseUseCase(this._authProvider, this._authenticationService);

  @override
  Future handle(SignInEnterpriseRequest request) async {
    var tokens = await _authenticationService.signInEnterprise(request);

    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    // Authenticates the use on the app
    _authProvider.authenticate(
      Authentication(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        user: User(
            name: decodedToken[Tokens.name],
            avatarUrl: decodedToken[Tokens.avatarUrl],
            level: decodedToken[Tokens.level],
            levelPercent: decodedToken[Tokens.levelPercent],
            sustainablePoints: decodedToken[Tokens.sustainablePoints]),
      ),
    );
  }
}
