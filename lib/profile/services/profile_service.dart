import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/profile/contracts/profiles_result.dart';

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

  // Future registerGroup(RegisterGroupRequest request) async {
  //   await _httpClient.makeRequestMultiPart(
  //     method: HttpMethods.post,
  //     path: "groups",
  //     body: request,
  //     expectedCode: 200,
  //   );
  // }
}
