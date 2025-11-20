import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/core/domain/models/store.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/auth/pre_authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/refresh_profile.dart';
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class SignInUseCase implements UseCase<SignInRequest, Future> {
  final AuthenticationProvider _authProvider;
  final AuthenticationService _authenticationService;

  SignInUseCase(
    this._authProvider,
    this._authenticationService,
  );

  @override
  Future handle(SignInRequest request) async {
    AuthResult tokens;
    RefreshProfile refreshProfile;

    try {
      tokens = await _authenticationService.signIn(request);
    } catch (e) {
      rethrow;
    }

    // Get Token value to populate the User Object
    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    var profileId = decodedToken[Tokens.profileId];
    var role = decodedToken[Tokens.role];

    try {
      _authProvider
          .preAuthenticate(PreAuthentication(accessToken: tokens.accessToken));

      await request.strategy.createProfile();

      refreshProfile = await _authProvider.refreshProfile(
        tokens,
        profileId: profileId,
      );
    } catch (e) {
      rethrow;
    }

    // Authenticates the use on the app
    _authProvider.authenticate(
      Authentication(
        accessToken: refreshProfile.tokens.accessToken,
        refreshToken: refreshProfile.tokens.refreshToken,
        user: User(
          id: refreshProfile.profile.id,
          name: refreshProfile.profile.username,
          avatarUrl: refreshProfile.profile.avatarUrl,
          level: refreshProfile.profile.level.toString(),
          levelPercent: refreshProfile.profile.levelPercentage.toString(),
          sustainablePoints:
              refreshProfile.profile.sustainabilityPoints.toString(),
          ecoScore: refreshProfile.profile.ecoScorePoints.toString(),
          ecoCoins: refreshProfile.profile.ecoCoins.toString(),
          xp: refreshProfile.profile.xp.toString(),
          nextLevelXp: refreshProfile.profile.nextLevelUp.toString(),
          type: UserType.getOf(role),
          phoneNumber: Phone.create(refreshProfile.profile.phoneCountry,
              refreshProfile.profile.phoneNumber),
        ),
      ),
    );

    StorageService.setValue(Store.profileId, refreshProfile.profile.id);

    var provider = DependencyInjection.locator<StaticValuesProvider>();
    await provider.fetchAuthorizedValues();
  }
}
