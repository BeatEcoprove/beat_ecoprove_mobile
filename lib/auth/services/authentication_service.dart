import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/forgotpassword_request.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/contracts/ping_server.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/contracts/resetpassword_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_request.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class AuthenticationService {
  final HttpClient _httpClient;

  AuthenticationService(this._httpClient);

  Future<PingServerResult> pingServer() async {
    return PingServerResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "health",
      expectedCode: 200,
    ));
  }

  Future<AuthResult> signIn(SignInRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "auth/sign-up",
        body: request,
        expectedCode: 201));
  }

  Future<AuthResult> refreshTokens(RefreshTokensRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestFormUrlEncoded(
        method: HttpMethods.post,
        path: "auth/token",
        body: request,
        expectedCode: 200));
  }

  Future<AuthResult> login(LoginRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestFormUrlEncoded(
      method: HttpMethods.post,
      path: "auth/token",
      body: request,
      expectedCode: 200,
    ));
  }

  Future<void> sendForgotPassword(ForgotPasswordRequest request) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "auth/forgot-password",
        body: request,
        expectedCode: 200);
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "auth/reset-password",
        body: request,
        expectedCode: 200);
  }

  Future<bool> validateEmailField(String email) async {
    var result = await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path: "auth/availability/check-field?email=$email",
        expectedCode: 200);

    return !(bool.tryParse(result['message']) ?? true);
  }

//FIXME: Check later
  Future<bool> validateUsernameField(String username) async {
    var result = await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path: "availability/check-field?username=$username",
        expectedCode: 200);

    return !(bool.tryParse(result['message']) ?? true);
  }
}
