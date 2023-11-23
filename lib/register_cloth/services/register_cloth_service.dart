import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';
import 'package:beat_ecoprove/register_cloth/contracts/register_cloth_request.dart';

class RegisterClothService {
  final HttpAuthClient _httpClient;

  RegisterClothService(this._httpClient);

  Future registerCloth(RegisterClothRequest request, String profileId) async {
    await _httpClient.makeRequestMultiPart(
        method: HttpMethods.post,
        path: "profile/$profileId/closet/cloth",
        body: request,
        expectedCode: 201);
  }
}
