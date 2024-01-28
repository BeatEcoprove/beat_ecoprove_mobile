import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/notification_provider.dart';
import 'package:beat_ecoprove/core/providers/notifications/notification_manager.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/websocket_auth_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/notifier.dart';
import 'package:beat_ecoprove/core/providers/websockets/websocket_notifier.dart';
import 'package:beat_ecoprove/group/services/group_service.dart';

class AuthWSNotifier extends Notifier {
  final WSSessionManager websocketNotifier;
  final AuthenticationProvider authenticationProvider;
  late bool isListening = false;

  AuthWSNotifier(
      this.websocketNotifier,
      this.authenticationProvider,
      LevelUpProvider levelUpProvider,
      NotificationProvider notificationProvider,
      NotificationManager notificationManager,
      GroupService groupService)
      : super(
          levelUpProvider,
          notificationProvider,
          notificationManager,
          groupService,
        );

  void listen() {
    var token = authenticationProvider.accessToken;
    var authChannel = websocketNotifier.createChannel('auth', token);

    if (!isListening) {
      isListening = true;
      authChannel.stream.listen(
        (event) {
          var handler = getWebSocketMessage(event);

          if (handler == null) {
            return;
          }

          handler.handle();
        },
        onDone: () {
          websocketNotifier.removeChannel('auth');
          isListening = false;
        },
      );
    }

    websocketNotifier.sendMessage('auth', AuthWebSocketMessage());
  }
}
