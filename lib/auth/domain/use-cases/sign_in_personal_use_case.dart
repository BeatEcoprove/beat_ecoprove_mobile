import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/core/domain/entities/consumer.dart';
import 'package:beat_ecoprove/core/domain/entities/employee.dart';
import 'package:beat_ecoprove/core/domain/entities/organization.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class SignInPersonalUseCase implements UseCase<SignInPersonalRequest, Future> {
  final AuthenticationProvider _authProvider;
  final AuthenticationService _authenticationService;

  SignInPersonalUseCase(this._authProvider, this._authenticationService);

  @override
  Future handle(SignInPersonalRequest request) async {
    AuthResult tokens;

    try {
      tokens = await _authenticationService.signInPersonal(request);
    } catch (e) {
      rethrow;
    }

    // Get Token value to populate the User Object
    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    // Authenticates the use on the app
    _authProvider.authenticate(
      Authentication(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        user: switch (UserType.getOf(decodedToken[Tokens.type])) {
          UserType.consumer => Consumer(
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
          UserType.organization => Organization(
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
          UserType.employee => Employee(
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
              workerType: EmployeeType.getOf(decodedToken[Tokens.role]),
            ),
        },
      ),
    );
  }
}
