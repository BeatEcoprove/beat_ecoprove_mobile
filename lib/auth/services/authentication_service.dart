import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class AuthenticationService {
  final HttpClient _httpClient;

  AuthenticationService(this._httpClient);

  Future<AuthResult> signInPersonal(SignInPersonalRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestMultiPart(
        method: HttpMethods.post,
        path: "auth/signIn/personal",
        body: request,
        expectedCode: 201));
  }

  Future<AuthResult> signInEnterprise(SignInEnterpriseRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestMultiPart(
        method: HttpMethods.post,
        path: "auth/signIn/enterprise",
        body: request,
        expectedCode: 201));
  }

  Future<AuthResult> refreshTokens(RefreshTokensRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path: "auth/refresh_tokens",
        expectedCode: 200));
  }

  Future<AuthResult> login(LoginRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "auth/login",
        body: request,
        expectedCode: 200));
  }
}
