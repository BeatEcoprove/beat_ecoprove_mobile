import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_level_message.dart';

class LevelUpHandler extends Handler<WebsocketLevelMessage> {
  final LevelUpProvider levelUpProvider;

  LevelUpHandler(WebsocketLevelMessage message, this.levelUpProvider)
      : super(message);

  @override
  void handle() {
    levelUpProvider.showLevelUpNotification(level: message.level);
  }
}
