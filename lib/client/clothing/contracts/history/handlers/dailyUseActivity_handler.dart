import 'package:beat_ecoprove/client/clothing/contracts/history/handlers/historyAction_handler.dart';
import 'package:beat_ecoprove/client/clothing/contracts/history/responses/dailyUseActivity_result.dart';
import 'package:beat_ecoprove/client/clothing/domain/models/history_item.dart';

class HistoryActionDailyUseActivityHandler
    extends HistoryActionHandler<HistoryActionDailyUseActivityResult> {
  HistoryActionDailyUseActivityHandler(
      HistoryActionDailyUseActivityResult message)
      : super(message);

  @override
  HistoryItem handle() {
    return HistoryItem(
      actionName: message.title,
      endedAt: message.endedAt,
    );
  }
}
