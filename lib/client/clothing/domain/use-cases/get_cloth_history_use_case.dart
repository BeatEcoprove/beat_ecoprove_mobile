import 'package:beat_ecoprove/client/clothing/contracts/history/handlers/dailyUseActivity_handler.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/handlers/historyAction_handler.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/handlers/maintenanceActivity_handler.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/history_action_type.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/requests/history_action_request.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/history_action_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/responses/dailyUseActivity_result.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/responses/maintenanceActivity_result.dart';
import 'package:beat_ecoprove/client/clothing/domain/models/history_item.dart';
import 'package:beat_ecoprove/client/clothing/services/cloth_service.dart';
import 'package:beat_ecoprove/core/use_case.dart';

class GetClothHistoryUseCase implements UseCase<HistoryActionRequest, Future> {
  final ClothService _clothService;

  GetClothHistoryUseCase(this._clothService);

  @override
  Future<List<HistoryItem>> handle(HistoryActionRequest request) async {
    List<HistoryActionResult> historyActionResult = [];
    List<HistoryItem> clothHistory = [];
    String params = '';

    if (request.params.isNotEmpty) {
      params = _prepareRequest(request.params);
    }

    try {
      historyActionResult = await _clothService.getClothHistory(
        request.clothId,
        request.page,
        request.pageSize,
        params,
      );
    } catch (e) {
      rethrow;
    }

    HistoryActionHandler handler;

    for (var history in historyActionResult) {
      if (history.type == HistoryActionType.dailyUse) {
        handler = HistoryActionDailyUseActivityHandler(
            history as HistoryActionDailyUseActivityResult);
      } else {
        handler = HistoryActionMaintenanceActivityHandler(
            history as HistoryActionMaintenanceActivityResult);
      }
      // HistoryActionType.maintenance:

      var result = handler.handle();
      clothHistory.add(result);
    }
    return clothHistory;
  }

  String _prepareRequest(Map<String, String> params) {
    Set<String> tags = {};
    String endPoint = '&';

    for (var param in params.values) {
      tags.add(param);
    }

    for (var tag in tags) {
      endPoint +=
          '$tag=${params.entries.where((entry) => entry.value.contains(tag)).map((entry) => entry.key).join(',')}';
      endPoint += '&';
    }

    return endPoint;
  }
}
