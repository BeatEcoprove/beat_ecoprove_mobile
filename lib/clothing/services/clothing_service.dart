import 'package:beat_ecoprove/clothing/contracts/closet_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class ClothingService {
  final HttpAuthClient _httpClient;

  ClothingService(this._httpClient);

  Future<ClosetResult> getCloset(String profileId) async {
    return ClosetResult.fromJson(await _httpClient.makeRequestJson(
        method: HttpMethods.get,
        path: "profile/$profileId/closet",
        expectedCode: 200));
  }
}
