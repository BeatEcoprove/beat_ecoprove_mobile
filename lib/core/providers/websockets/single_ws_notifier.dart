import 'package:beat_ecoprove/core/providers/auth/authentication_provider.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/websocket_group_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/websocket_sendtext_message.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/requests/websocket_sendtradeoffer_message.dart';
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
    super.groupManager,
    super.groupService,
  );

  String get accessToken => authenticationProvider.refreshToken;
  bool get isTokenAvailable => accessToken.isEmpty;

  Future _listen() async {
    if (isTokenAvailable) {
      return;
    }

    var channel = await websocketNotifier.createChannel(
      accessToken,
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
  void sendMessageOnGroup(String id, String message);
  void sendTradeOfferOnGroup(String id, String message, String clothId);
  void exitGroup(String id);
}

class SingleConnectionWsNotifier extends IWCNotifier {
  late bool isOnActiveGroup = false;

  SingleConnectionWsNotifier(
      super.websocketNotifier,
      super.authenticationProvider,
      super.levelUpProvider,
      super.notificationProvider,
      super.notificationManager,
      super.groupManager,
      super.groupService);

  @override
  void enterGroup(String id) {
    if (isOnActiveGroup) {
      return;
    }

    websocketNotifier.sendMessage(
      ConnectGroupWebSocketMessage(id),
      accessToken,
    );

    isOnActiveGroup = true;
  }

  @override
  void exitGroup(String id) {
    isOnActiveGroup = false;
  }

  @override
  void sendMessageOnGroup(String id, String message) {
    if (!isOnActiveGroup) {
      return;
    }

    websocketNotifier.sendMessage(
      SendTextWebSocketMessage(
        id,
        message,
      ),
      accessToken,
    );
  }

  @override
  void sendTradeOfferOnGroup(String id, String message, String clothId) {
    if (!isOnActiveGroup) {
      return;
    }

    websocketNotifier.sendMessage(
      SendTradeOfferWebSocketMessage(
        id,
        message,
        clothId,
      ),
      accessToken,
    );
  }
}
