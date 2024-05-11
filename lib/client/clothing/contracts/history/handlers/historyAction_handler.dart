import 'package:beat_ecoprove/client/clothing/domain/models/history_item.dart';

abstract class HistoryActionHandler<T> {
  late T message;

  HistoryActionHandler(this.message);

  HistoryItem handle();
}
