import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/core/helpers/http/errors/http_error.dart';
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
    AuthResult tokens;

    try {
      tokens = await _authenticationService.signInEnterprise(request);
    } on HttpError catch (e) {
      throw Exception(e.getError().title);
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    // Authenticates the use on the app
    _authProvider.authenticate(
      Authentication(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        user: User(
          id: decodedToken[Tokens.id],
          name: decodedToken[Tokens.name],
          avatarUrl: decodedToken[Tokens.avatarUrl],
          level: decodedToken[Tokens.level],
          levelPercent: decodedToken[Tokens.levelPercent],
          sustainablePoints: decodedToken[Tokens.sustainablePoints],
          ecoScore: decodedToken[Tokens.ecoScore],
          ecoCoins: decodedToken[Tokens.ecoCoins],
          xp: decodedToken[Tokens.xp],
          nextLevelXp: decodedToken[Tokens.nextLevelXp],
        ),
      ),
    );
  }
}
