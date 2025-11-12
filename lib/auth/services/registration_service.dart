import 'package:beat_ecoprove/auth/contracts/profile_result.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sign_in_personal_request.dart';
import 'package:beat_ecoprove/auth/contracts/sign_in/sing_in_enterprise_request.dart';
import 'package:beat_ecoprove/client/profile/contracts/profile_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class RegistrationService {
  final HttpAuthClient _httpClient;

  RegistrationService(this._httpClient);

  Future<ProfileResult> getTokenData() async {
    return ProfileResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "auth/profiles/me",
      expectedCode: 200,
    ));
  }

  Future<FinishProfileResult> getProfileData() async {
    return FinishProfileResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles/me",
      expectedCode: 200,
    ));
  }

  Future<FinishProfileResult> createClient(
      SignInPersonalRequest request) async {
    return FinishProfileResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "profiles/client",
        body: request,
        expectedCode: 201));
  }

  Future<FinishProfileResult> createOrganization(
      SignInEnterpriseRequest request) async {
    return FinishProfileResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.post,
        path: "profiles/organization",
        body: request,
        expectedCode: 201));
  }
}
