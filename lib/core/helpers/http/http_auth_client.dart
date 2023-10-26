import 'package:beat_ecoprove/auth/contracts/common/base_request.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/services/authentication_service.dart';
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

  void refreshTokens() async {
    String refreshToken = _authenticationProvider.refreshToken;

    var tokens = await _authenticationService
        .refreshTokens(RefreshTokensRequest(refreshToken: refreshToken));

    Map<String, dynamic> decodedToken = JwtDecoder.decode(tokens.accessToken);

    _authenticationProvider.authenticate(Authentication(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      user: User(
          name: decodedToken[Tokens.name],
          avatarUrl: decodedToken[Tokens.avatarUrl],
          level: decodedToken[Tokens.level],
          levelPercent: decodedToken[Tokens.levelPercent],
          sustainablePoints: decodedToken[Tokens.sustainablePoints]),
    ));
  }

  @override
  Future<T> makeRequestJson<T, U>(
      {required String method,
      required String path,
      BaseJsonRequest? body,
      Map<String, String>? headers}) {
    refreshTokens();

    return _httpClient.makeRequestJson(
        method: method,
        path: path,
        body: body,
        headers: {"Authorization": _authenticationProvider.accessToken});
  }

  @override
  Future<U> makeRequestMultiPart<U>(
      {required String method,
      required String path,
      required BaseMultiPartRequest body,
      Map<String, String>? headers}) {
    refreshTokens();

    return _httpClient.makeRequestMultiPart(
        method: method,
        path: path,
        body: body,
        headers: {"Authorization": _authenticationProvider.accessToken});
  }
}
