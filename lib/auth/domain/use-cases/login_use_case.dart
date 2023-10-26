import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/store.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class LoginUseCase implements UseCase<LoginRequest, Future> {
  final AuthenticationProvider _authProvider;
  final AuthenticationService _authenticationService;

  LoginUseCase(this._authProvider, this._authenticationService);

  @override
  Future handle(LoginRequest request) async {
    var tokens = await _authenticationService.login(request);

    // Persist tokens on shared preferences
    StorageService.setValue(Store.refreshToken, tokens.refreshToken);

    // Get Token value to populate the User Object
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
