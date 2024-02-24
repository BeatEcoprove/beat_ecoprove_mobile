import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/notifier.dart';
import 'package:beat_ecoprove/core/providers/websockets/websocket_notifier.dart';

abstract class IWCNotifier extends Notifier {
  final IWebSocketManager websocketNotifier;
  final AuthenticationProvider authenticationProvider;

  late bool isGraceFullExit = false;

  IWCNotifier(
    this.websocketNotifier,
    this.authenticationProvider,
    super.levelUpProvider,
    super.notificationProvider,
    super.notificationManager,
    super.groupService,
  );

  Future _listen() async {
    var token = authenticationProvider.refreshToken;

    if (token.isEmpty) {
      return;
    }

    var channel = await websocketNotifier.createChannel(
      token,
    );

    channel.stream.listen(
      (event) {
        var handler = getWebSocketMessage(event);

        if (handler == null) {
          return;
        }

        handler.handle();
      },
      onDone: () async {
        websocketNotifier.close();

        if (!isGraceFullExit) {
          return await reconnect();
        }

        isGraceFullExit = !isGraceFullExit;
      },
    );
  }

  Future logIn() async {
    await _listen();
  }

  void logOut() {
    websocketNotifier.close();
    isGraceFullExit = true;
  }

  Future reconnect() async {
    if (!websocketNotifier.isAlive()) {
      await logIn();
    }
  }

  void enterGroup(String id);
  void messageGroup(String id, String message, String who);
  void exitGroup(String id);
}

class SingleConnectionWsNotifier extends IWCNotifier {
  SingleConnectionWsNotifier(
    super.websocketNotifier,
    super.authenticationProvider,
    super.levelUpProvider,
    super.notificationProvider,
    super.notificationManager,
    super.groupManager,
  );

  @override
  void enterGroup(String id) {}

  @override
  void exitGroup(String id) {}

  @override
  void messageGroup(String id, String message, String who) {}
}
