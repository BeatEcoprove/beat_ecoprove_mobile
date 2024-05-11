import 'package:beat_ecoprove/client/clothing/contracts/history/history_action_type.dart';

class HistoryActionResult {
  final HistoryActionType type;
  final DateTime endedAt;

  HistoryActionResult.fromJson(Map<String, dynamic> json)
      : type = HistoryActionType.getOf(json['type']),
        endedAt = DateTime.parse(json['endedAt']);
}
