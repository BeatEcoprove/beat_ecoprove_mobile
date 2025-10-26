import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/core/domain/entities/consumer.dart';
import 'package:beat_ecoprove/core/domain/entities/employee.dart';
import 'package:beat_ecoprove/core/domain/entities/organization.dart';
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
    AuthResult tokens;
    ProfileResult profile;

    try {
      tokens = await _authenticationService.login(request);
    } catch (e) {
      rethrow;
    }

    // Persist tokens on shared preferences
    StorageService.setValue(Store.refreshToken, tokens.refreshToken);

    // Get Token value to populate the User Object
    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    var profileId = decodedToken[Tokens.profileId];

    try {
      tokens = await _authenticationService.refreshTokens(RefreshTokensRequest(
          refreshToken: tokens.refreshToken, profileId: profileId));

      profile = await _authenticationService.getProfileData();
    } catch (e) {
      rethrow;
    }

    // Authenticates the use on the app
    _authProvider.authenticate(
      Authentication(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        user: switch (UserType.getOf(decodedToken[Tokens.type])) {
          UserType.consumer => Consumer(
              id: profile.id,
              name: profile.username,
              avatarUrl: profile.avatarUrl,
              level: profile.level.toString(),
              levelPercent: profile.levelPercentage.toString(),
              sustainablePoints: profile.sustainabilityPoints.toString(),
              ecoScore: profile.ecoScorePoints.toString(),
              ecoCoins: profile.ecoCoins.toString(),
              xp: profile.xp.toString(),
              nextLevelXp: profile.nextLevelUp.toString(),
            ),
          UserType.organization => Organization(
              id: profile.id,
              name: profile.username,
              avatarUrl: profile.avatarUrl,
              level: profile.level.toString(),
              levelPercent: profile.levelPercentage.toString(),
              sustainablePoints: profile.sustainabilityPoints.toString(),
              ecoScore: profile.ecoScorePoints.toString(),
              ecoCoins: profile.ecoCoins.toString(),
              xp: profile.xp.toString(),
              nextLevelXp: profile.nextLevelUp.toString(),
            ),
          UserType.employee => Employee(
              id: profile.id,
              name: profile.username,
              avatarUrl: profile.avatarUrl,
              level: profile.level.toString(),
              levelPercent: profile.levelPercentage.toString(),
              sustainablePoints: profile.sustainabilityPoints.toString(),
              ecoScore: profile.ecoScorePoints.toString(),
              ecoCoins: profile.ecoCoins.toString(),
              xp: profile.xp.toString(),
              nextLevelXp: profile.nextLevelUp.toString(),
              // FIXME: change when open service providers
              workerType: EmployeeType.getOf(decodedToken[Tokens.role]),
              storeId: decodedToken[Tokens.storeId],
            ),
        },
      ),
    );
  }
}
