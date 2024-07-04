import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
import 'package:beat_ecoprove/core/domain/entities/consumer.dart';
import 'package:beat_ecoprove/core/domain/entities/employee.dart';
import 'package:beat_ecoprove/core/domain/entities/organization.dart';
import 'package:beat_ecoprove/core/domain/entities/user.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/helpers/json_decoder.dart';
import 'package:beat_ecoprove/core/helpers/tokens.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication.dart';
import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';

class HttpAuthClient implements HttpClient {
  final HttpClient _httpClient;
  final AuthenticationProvider _authenticationProvider;
  final AuthenticationService _authenticationService;

  HttpAuthClient(this._httpClient, this._authenticationProvider,
      this._authenticationService);

  Future refreshTokens() async {
    if (!_authenticationProvider.isAuthenticated) {
      return;
    }

    String refreshToken = _authenticationProvider.refreshToken;

    var tokens = await _authenticationService.refreshTokens(
        RefreshTokensRequest(
            refreshToken: refreshToken,
            profileId: _authenticationProvider.profile));

    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    _authenticationProvider.authenticate(Authentication(
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
            storeId: decodedToken[Tokens.storeId],
          ),
      },
    ));
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
    await refreshTokens();

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
    await refreshTokens();

    return _httpClient.makeRequestMultiPart(
        method: method,
        path: parseProfileId(path),
        body: body,
        headers: {
          "Authorization": 'Bearer ${_authenticationProvider.accessToken}'
        },
        expectedCode: expectedCode);
  }
}
