import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/level_up_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/websocket_auth_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/notifier.dart';
import 'package:beat_ecoprove/core/providers/websockets/websocket_notifier.dart';

class AuthWSNotifier extends Notifier {
  final WSSessionManager websocketNotifier;
  final AuthenticationProvider authenticationProvider;
  final LevelUpProvider levelUpProvider;
  late bool isListening = false;

  AuthWSNotifier(
      this.websocketNotifier, this.authenticationProvider, this.levelUpProvider)
      : super(levelUpProvider);

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
