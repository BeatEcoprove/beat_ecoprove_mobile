import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/profile/contracts/profiles_result.dart';
import 'package:beat_ecoprove/profile/contracts/promote_profile_request.dart';
import 'package:beat_ecoprove/profile/contracts/register_profile_request.dart';

class ProfileService {
  final HttpAuthClient _httpClient;

  ProfileService(this._httpClient);

  Future<ProfilesResult> getNestedProfiles() async {
    return ProfilesResult.fromJson(await _httpClient.makeRequestJson(
      method: HttpMethods.get,
      path: "profiles",
      expectedCode: 200,
    ));
  }

  Future removeNestedProfile(String profileId) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.delete,
      path: "profiles/$profileId",
      expectedCode: 200,
    );
  }

  Future promoteNestedProfile(PromoteProfileRequest request) async {
    await _httpClient.makeRequestJson(
      method: HttpMethods.put,
      path: "profiles/${request.profileId}/promote",
      body: request,
      expectedCode: 200,
    );
  }

  Future registerProfile(RegisterProfileRequest request) async {
    await _httpClient.makeRequestMultiPart(
      method: HttpMethods.post,
      path: "profiles",
      body: request,
      expectedCode: 200,
    );
  }
}
