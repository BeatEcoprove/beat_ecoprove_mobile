import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/domain/value_objects/phone.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/auth/services/registration_service.dart';
import 'package:beat_ecoprove/core/domain/entities/consumer.dart';
import 'package:beat_ecoprove/core/domain/entities/employee.dart';
import 'package:beat_ecoprove/core/domain/entities/organization.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';

class HttpAuthClient implements HttpClient {
  final HttpClient _httpClient;
  final AuthenticationProvider _authenticationProvider;
  final AuthenticationService _authenticationService;

  HttpAuthClient(this._httpClient, this._authenticationProvider,
      this._authenticationService);

  Future refreshTokens() async {
    FinishProfileResult profileData;

    if (!_authenticationProvider.isAuthenticated) {
      return;
    }

    String refreshToken = _authenticationProvider.refreshToken;

    try {
      var tokens = await _authenticationService.refreshTokens(
          RefreshTokensRequest(
              refreshToken: refreshToken,
              profileId: _authenticationProvider.profile));

      if (tokens.accessToken.trim().isEmpty) {
        await _authenticationProvider.logout();
        return;
      }

      Map<String, dynamic> decodedToken;

      try {
        decodedToken = JwtDecoder.decode(tokens.accessToken);
      } catch (e) {
        await _authenticationProvider.logout();
        return;
      }

      try {
        profileData = await DependencyInjection.locator<RegistrationService>()
            .getProfileData();
      } catch (e) {
        return;
      }

      _authenticationProvider.authenticate(Authentication(
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
              workerType: EmployeeType.getOf(decodedToken[Tokens.role]),
              storeId: decodedToken[Tokens.storeId],
            ),
        },
      ));
    } catch (e) {
      try {
        await _authenticationProvider.logout();
      } catch (_) {}
      return;
    }
  }

  String parseProfileId(String path) {
    var profileId = _authenticationProvider.profileId;

    if (profileId.isEmpty) {
      return path;
    }

    if (path.contains("?")) {
      path += "&profileId=$profileId";
    } else {
      path += "?profileId=$profileId";
    }

    return path;
  }

  @override
  Future<U> makeRequestJson<U>(
      {required String method,
      required String path,
      BaseJsonRequest? body,
      Map<String, String>? headers,
      int expectedCode = 200}) async {
    if (!_authenticationProvider.accessTokenIsValid()) {
      await refreshTokens();
    }

    return _httpClient.makeRequestJson(
        method: method,
        path: parseProfileId(path),
        body: body,
        headers: {
          "Authorization": 'Bearer ${_authenticationProvider.accessToken}'
        },
        expectedCode: expectedCode);
  }

  @override
  Future<U> makeRequestMultiPart<U>(
      {required String method,
      required String path,
      required BaseMultiPartRequest body,
      Map<String, String>? headers,
      int expectedCode = 200}) async {
    if (!_authenticationProvider.accessTokenIsValid()) {
      await refreshTokens();
    }

    return _httpClient.makeRequestMultiPart(
        method: method,
        path: parseProfileId(path),
        body: body,
        headers: {
          "Authorization": 'Bearer ${_authenticationProvider.accessToken}'
        },
        expectedCode: expectedCode);
  }

  @override
  Future<U> makeRequestFormUrlEncoded<U>(
      {required String method,
      required String path,
      required BaseFormUrlEncodedRequest body,
      Map<String, String>? headers,
      int expectedCode = 200}) async {
    if (!_authenticationProvider.accessTokenIsValid()) {
      await refreshTokens();
    }

    return _httpClient.makeRequestFormUrlEncoded(
        method: method,
        path: parseProfileId(path),
        body: body,
        headers: {
          "Authorization": 'Bearer ${_authenticationProvider.accessToken}'
        },
        expectedCode: expectedCode);
  }
}
