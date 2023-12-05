import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class OutfitService {
  final HttpAuthClient _httpClient;

  OutfitService(this._httpClient);

  Future markClothAsInUse(String idCloth) async {
    return await _httpClient.makeRequestJson(
        method: HttpMethods.put,
        path: "profiles/closet/cloth/${idCloth}/use",
        expectedCode: 200);
  }

  Future unMarkClothAsInUse(String idCloth) async {
    return await _httpClient.makeRequestJson(
        method: HttpMethods.put,
        path: "profiles/closet/cloth/${idCloth}/unUse",
        expectedCode: 200);
  }
}
