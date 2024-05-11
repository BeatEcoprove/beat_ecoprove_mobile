import 'package:beat_ecoprove/client/clothing/contracts/history/handlers/historyAction_handler.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/responses/maintenanceActivity_result.dart';
import 'package:beat_ecoprove/client/clothing/domain/models/history_item.dart';

class HistoryActionMaintenanceActivityHandler
    extends HistoryActionHandler<HistoryActionMaintenanceActivityResult> {
  HistoryActionMaintenanceActivityHandler(dynamic message) : super(message);

  @override
  HistoryItem handle() {
    return HistoryItem(
        actionName: '${message.providedAction} ${message.providedService}',
        endedAt: message.endedAt);
  }
}
