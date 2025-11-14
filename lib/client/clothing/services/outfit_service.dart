import 'package:beat_ecoprove/client/clothing/contracts/mark_cloth_in_use_request.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class OutfitService {
  final HttpAuthClient _httpClient;

  OutfitService(this._httpClient);

  Future markClothAsInUse(MarkClothAsDailyUseRequest request) async {
    for (var idCloth in request.clothIds) {
      await _httpClient.makeRequestJson(
        method: HttpMethods.patch,
        path: "core/profiles/closet/cloth/$idCloth/usage?use=${request.usage}",
        expectedCode: 200,
      );
    }

    return;
  }
}
