import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
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
import 'package:beat_ecoprove/core/providers/static_values_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_ws_notifier.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class LoginUseCase implements UseCase<LoginRequest, Future> {
  final AuthenticationProvider _authProvider;
  final AuthenticationService _authenticationService;

  LoginUseCase(
    this._authProvider,
    this._authenticationService,
  );

  @override
  Future handle(LoginRequest request) async {
    AuthResult tokens;
    FinishProfileResult profileData;

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
      var refreshProfile = await _authProvider.refreshProfile(
        AuthResult(tokens.accessToken, tokens.refreshToken),
        profileId: profileId,
      );

      profileData = refreshProfile.profile;
      tokens = refreshProfile.tokens;
    } catch (e) {
      rethrow;
    }

    // Authenticates the use on the app
    _authProvider.authenticate(
      Authentication(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        user: switch (UserType.getOf(decodedToken[Tokens.role])) {
          UserType.consumer => Consumer(
              id: profileData.id,
              name: profileData.username,
              avatarUrl: profileData.avatarUrl,
              level: profileData.level.toString(),
              levelPercent: profileData.levelPercentage.toString(),
              sustainablePoints: profileData.sustainabilityPoints.toString(),
              ecoScore: profileData.ecoScorePoints.toString(),
              ecoCoins: profileData.ecoCoins.toString(),
              xp: profileData.xp.toString(),
              nextLevelXp: profileData.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  profileData.phoneCountry, profileData.phoneNumber),
            ),
          UserType.organization => Organization(
              id: profileData.id,
              name: profileData.username,
              avatarUrl: profileData.avatarUrl,
              level: profileData.level.toString(),
              levelPercent: profileData.levelPercentage.toString(),
              sustainablePoints: profileData.sustainabilityPoints.toString(),
              ecoScore: profileData.ecoScorePoints.toString(),
              ecoCoins: profileData.ecoCoins.toString(),
              xp: profileData.xp.toString(),
              nextLevelXp: profileData.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  profileData.phoneCountry, profileData.phoneNumber),
            ),
          UserType.employee => Employee(
              id: profileData.id,
              name: profileData.username,
              avatarUrl: profileData.avatarUrl,
              level: profileData.level.toString(),
              levelPercent: profileData.levelPercentage.toString(),
              sustainablePoints: profileData.sustainabilityPoints.toString(),
              ecoScore: profileData.ecoScorePoints.toString(),
              ecoCoins: profileData.ecoCoins.toString(),
              xp: profileData.xp.toString(),
              nextLevelXp: profileData.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  profileData.phoneCountry, profileData.phoneNumber),
              // FIXME: change when open service providers
              workerType: EmployeeType.getOf(decodedToken[Tokens.role]),
              storeId: decodedToken[Tokens.storeId],
            ),
        },
      ),
    );

    try {
      await DependencyInjection.locator<IPhoenixWsNotifier>().reconnect();
    } catch (e) {
      print(e);
    }

    var provider = DependencyInjection.locator<StaticValuesProvider>();
    await provider.fetchAuthorizedValues();
  }
}
