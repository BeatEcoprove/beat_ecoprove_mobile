import 'dart:async';

import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/auth/routes.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/auth/services/registration_service.dart';
import 'package:beat_ecoprove/core/domain/entities/consumer.dart';
import 'package:beat_ecoprove/core/domain/entities/employee.dart';
import 'package:beat_ecoprove/core/domain/entities/organization.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/domain/models/store.dart';
import 'package:beat_ecoprove/core/providers/auth/pre_authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/refresh_profile.dart';
import 'package:beat_ecoprove/core/providers/websockets/phoenix_ws_notifier.dart';
import 'package:beat_ecoprove/core/services/storage_service.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class AuthenticationProvider extends ViewModel {
  late bool _isAuthenticated = false;
  late String profileId = '';
  late User? _appUser;
  late String? _accessToken;
  late String _refreshToken = '';

  AuthenticationProvider() {
    _appUser = null;
    _accessToken = null;
  }

  Future<bool> checkAuth() async {
    String refreshToken =
        await StorageService.getValue(Store.refreshToken) ?? '';

    _refreshToken = refreshToken;

    if (refreshToken.isEmpty || !validateToken(refreshToken)) {
      logout();
      return false;
    }

    //FIXME: Ws
    // DependencyInjection.locator<IPhoenixWsNotifier>().logIn();

    Map<String, dynamic> decodedToken = JwtDecoder.decode(refreshToken);

    RefreshProfile result = await refreshProfile(
        AuthResult(refreshToken, refreshToken), decodedToken[Tokens.profileId]);

    authenticate(
      Authentication(
        accessToken: result.tokens.accessToken,
        refreshToken: result.tokens.refreshToken,
        user: switch (UserType.getOf(decodedToken[Tokens.role])) {
          UserType.consumer => Consumer(
              id: result.profile.id,
              name: result.profile.username,
              avatarUrl: result.profile.avatarUrl,
              level: result.profile.level.toString(),
              levelPercent: result.profile.levelPercentage.toString(),
              sustainablePoints: result.profile.sustainabilityPoints.toString(),
              ecoScore: result.profile.ecoScorePoints.toString(),
              ecoCoins: result.profile.ecoCoins.toString(),
              xp: result.profile.xp.toString(),
              nextLevelXp: result.profile.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  result.profile.phoneCountry, result.profile.phoneNumber),
            ),
          UserType.organization => Organization(
              id: result.profile.id,
              name: result.profile.username,
              avatarUrl: result.profile.avatarUrl,
              level: result.profile.level.toString(),
              levelPercent: result.profile.levelPercentage.toString(),
              sustainablePoints: result.profile.sustainabilityPoints.toString(),
              ecoScore: result.profile.ecoScorePoints.toString(),
              ecoCoins: result.profile.ecoCoins.toString(),
              xp: result.profile.xp.toString(),
              nextLevelXp: result.profile.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  result.profile.phoneCountry, result.profile.phoneNumber),
            ),
          UserType.employee => Employee(
              id: result.profile.id,
              name: result.profile.username,
              avatarUrl: result.profile.avatarUrl,
              level: result.profile.level.toString(),
              levelPercent: result.profile.levelPercentage.toString(),
              sustainablePoints: result.profile.sustainabilityPoints.toString(),
              ecoScore: result.profile.ecoScorePoints.toString(),
              ecoCoins: result.profile.ecoCoins.toString(),
              xp: result.profile.xp.toString(),
              nextLevelXp: result.profile.nextLevelUp.toString(),
              phoneNumber: Phone.create(
                  result.profile.phoneCountry, result.profile.phoneNumber),
              workerType: EmployeeType.getOf(decodedToken[Tokens.role]),
              storeId: decodedToken[Tokens.storeId],
            ),
        },
      ),
    );

    return true;
  }

  bool validateToken(String refreshToken) {
    if (refreshToken.isEmpty) {
      return false;
    }

    return !JwtDecoder.isExpired(refreshToken);
  }

  void authenticate(Authentication authentication) {
    StorageService.setValue(Store.refreshToken, authentication.refreshToken);

    _appUser = authentication.user;
    _accessToken = authentication.accessToken;
    _refreshToken = authentication.refreshToken;
    _isAuthenticated = true;

    notifyListeners();
  }

  void preAuthenticate(PreAuthentication authentication) {
    StorageService.setValue(Store.refreshToken, authentication.refreshToken);

    _accessToken = authentication.accessToken;
    _refreshToken = authentication.refreshToken;
    _isAuthenticated = false;

    notifyListeners();
  }

  Future<RefreshProfile> refreshProfile(
      AuthResult token, String profileId) async {
    AuthResult tokens;
    FinishProfileResult profileData;

    await Future.delayed(const Duration(microseconds: 500));

    tokens = await DependencyInjection.locator<AuthenticationService>()
        .refreshTokens(RefreshTokensRequest(
            refreshToken: token.refreshToken, profileId: profileId));

    preAuthenticate(PreAuthentication(
        accessToken: tokens.accessToken, refreshToken: tokens.refreshToken));

    profileData = await DependencyInjection.locator<RegistrationService>()
        .getProfileData();

    return RefreshProfile(tokens: tokens, profile: profileData);
  }

  Future logout() async {
    DependencyInjection.locator<IPhoenixWsNotifier>().logOut();
    await StorageService.clearValue(Store.refreshToken);
    _appUser = null;
    _isAuthenticated = false;
    await DependencyInjection.locator<INavigationManager>()
        .pushAsync(AuthRoutes.login);
  }

  String get profile => profileId;
  String get refreshToken => _refreshToken;
  String get accessToken => _accessToken!;
  User? get appUser => _appUser;

  void setProfile({String profileId = ""}) {
    this.profileId = profileId;

    DependencyInjection.locator<AuthenticationService>().refreshTokens(
        RefreshTokensRequest(
            refreshToken: _refreshToken, profileId: profileId));

    notifyListeners();
  }

  bool accessTokenIsValid() {
    if (_accessToken == null) {
      return false;
    }

    return validateToken(_accessToken!);
  }

  bool get isAuthenticated => _isAuthenticated;
}
