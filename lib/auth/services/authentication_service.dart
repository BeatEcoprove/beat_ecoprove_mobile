import 'package:beat_ecoprove/auth/contracts/account_result.dart';
import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/forgotpassword_request.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/contracts/ping_server.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/contracts/resetpassword_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_request.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class AuthenticationService {
  final HttpClient _httpClient;

  AuthenticationService(this._httpClient);

  Future<PingServerResult> pingServer() async {
    return PingServerResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "ping",
      expectedCode: 200,
    ));
  }

  Future<AccountResult> getUserData() async {
    return AccountResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "auth/profiles/me",
      expectedCode: 200,
    ));
  }

  Future<AuthResult> signIn(SignInRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestMultiPart(
        method: HttpMethods.post,
        path: "auth/sign-up",
        body: request,
        expectedCode: 201));
  }

  Future<AuthResult> refreshTokens(RefreshTokensRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestFormUrlEncoded(
        method: HttpMethods.get,
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

  Future<ProfileResult> getProfileData() async {
    return ProfileResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "core/profiles/me",
      expectedCode: 200,
    ));
  }

  Future<AuthResult> createProfilePersonal(
      SignInPersonalRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestMultiPart(
        method: HttpMethods.post,
        path: "core/profiles/personal",
        body: request,
        expectedCode: 201));
  }

  Future<AuthResult> createProfileEnterprise(
      SignInEnterpriseRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestMultiPart(
        method: HttpMethods.post,
        path: "core/profiles/enterprise",
        body: request,
        expectedCode: 201));
  }

  Future<bool> validateEmailField(String email) async {
    var result = await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path: "auth/availability/check-field?email=$email",
        expectedCode: 200);

    return result['isAvailable'];
  }

  Future<bool> validateUsernameField(String username) async {
    var result = await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path: "core/availability/check-field?username=$username",
        expectedCode: 200);

    return result['isAvailable'];
  }
}
