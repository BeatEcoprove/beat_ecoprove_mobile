import 'package:beat_ecoprove/client/clothing/contracts/history/history_action_result.dart';

class HistoryActionDailyUseActivityResult extends HistoryActionResult {
  final String title;

  HistoryActionDailyUseActivityResult(Map<String, dynamic> json)
      : title = json['title'],
        super.fromJson(json);
}
