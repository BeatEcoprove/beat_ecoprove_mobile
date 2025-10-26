import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_request.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class SignInUseCase implements UseCase<SignInRequest, Future> {
  final AuthenticationProvider _authProvider;
  final AuthenticationService _authenticationService;

  SignInUseCase(this._authProvider, this._authenticationService);

  @override
  Future handle(SignInRequest request) async {
    AuthResult tokens;
    ProfileResult profile;

    try {
      tokens = await _authenticationService.signIn(request);

      await request.strategy.createProfile();
    } catch (e) {
      rethrow;
    }

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
        user: User(
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
      ),
    );
  }
}
