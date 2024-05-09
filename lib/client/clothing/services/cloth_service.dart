import 'package:beat_ecoprove/client/clothing/contracts/history_action_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history_action_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class ClothService {
  final HttpAuthClient _httpClient;

  ClothService(this._httpClient);

  Future<List<HistoryActionResult>> getClothHistory(
      HistoryActionRequest historyActionRequest) async {
    var result = await _httpClient.makeRequestJson<List<dynamic>>(
      method: HttpMethods.get,
      path: "clothes/${historyActionRequest.clothId}/history",
      expectedCode: 200,
    );

    return result.map((e) => HistoryActionResult.fromJson(e)).toList();
  }
}
