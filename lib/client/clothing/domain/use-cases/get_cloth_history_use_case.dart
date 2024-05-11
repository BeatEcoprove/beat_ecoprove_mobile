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

    try {
      historyActionResult = await _clothService.getClothHistory(request);
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
}
