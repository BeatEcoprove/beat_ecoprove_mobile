import 'package:beat_ecoprove/core/providers/websockets/dtos/websocket_result.dart';

abstract class Handler<TRequest extends WebsocketResult> {
  final TRequest message;

  Handler(this.message);

  void handle();
}
