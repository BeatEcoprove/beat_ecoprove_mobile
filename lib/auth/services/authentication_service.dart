import 'package:beat_ecoprove/auth/contracts/common/auth_result.dart';
import 'package:beat_ecoprove/auth/contracts/forgotpassword_request.dart';
import 'package:beat_ecoprove/auth/contracts/login_request.dart';
import 'package:beat_ecoprove/auth/contracts/refresh_tokens_request.dart';
import 'package:beat_ecoprove/auth/contracts/resetpassword_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/auth/contracts/validate_field_request.dart';
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
    var path =
        "auth/refresh_tokens?token=${request.refreshToken}${request.profileId.isNotEmpty ? "&profileId=${request.profileId}" : ""}";
    return AuthResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.get, path: path, expectedCode: 200));
  }

  Future<AuthResult> login(LoginRequest request) async {
    return AuthResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "auth/login",
        body: request,
        expectedCode: 200));
  }

  Future<void> sendForgotPassword(ForgotPasswordRequest request) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "auth/forgot_password",
        body: request,
        expectedCode: 200);
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "auth/reset_password?code=${request.code}",
        body: request,
        expectedCode: 200);
  }

  Future<bool> validateFields(ValidateFieldRequest request) async {
    var jsonRequest = request.toJson();

    var result = await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path:
            "auth/validate/check-field?fieldName=${jsonRequest['fieldName']}&value=${jsonRequest['value']}",
        expectedCode: 200);

    return result['isAvailable'];
  }
}
