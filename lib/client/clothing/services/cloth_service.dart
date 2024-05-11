import 'package:beat_ecoprove/client/clothing/contracts/history/history_action_type.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/requests/history_action_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/history_action_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/responses/dailyUseActivity_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/responses/maintenanceActivity_result.dart';
import 'package:beat_ecoprove/core/helpers/http/http_auth_client.dart';
import 'package:beat_ecoprove/core/helpers/http/http_methods.dart';

class ClothService {
  final HttpAuthClient _httpClient;

  ClothService(this._httpClient);

  Future<List<HistoryActionResult>> getClothHistory(
      HistoryActionRequest historyActionRequest) async {
    var json = await _httpClient.makeRequestJson<List<dynamic>>(
      method: HttpMethods.get,
      path:
          "profiles/closet/cloth/${historyActionRequest.clothId}/services/history",
      expectedCode: 200,
    );

    return json.map((e) {
      var result = HistoryActionResult.fromJson(e);
      switch (result.type) {
        case HistoryActionType.dailyUse:
          return HistoryActionDailyUseActivityResult(e);
        case HistoryActionType.maintenance:
          return HistoryActionMaintenanceActivityResult(e);
        default:
          return result;
      }
    }).toList();
  }
}
