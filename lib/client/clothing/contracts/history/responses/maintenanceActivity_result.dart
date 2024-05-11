import 'package:beat_ecoprove/client/clothing/contracts/history/history_action_result.dart';

class HistoryActionMaintenanceActivityResult extends HistoryActionResult {
  final String providedService;
  final String providedAction;

  HistoryActionMaintenanceActivityResult(Map<String, dynamic> json)
      : providedService = json['providedService'],
        providedAction = json['providedAction'],
        super.fromJson(json);
}
