import 'package:beat_ecoprove/core/providers/websockets/dtos/handlers/handler.dart';
import 'package:beat_ecoprove/core/providers/websockets/dtos/responses/websocket_accept_group_connection_message.dart';

class AcceptGroupConnectionHandler
    extends Handler<WebsocketAcceptGroupConnectionMessage> {
  AcceptGroupConnectionHandler(super.message);

  @override
  void handle() {
    print("It did connection to the Group !!");
    print(message.message);
  }
}
