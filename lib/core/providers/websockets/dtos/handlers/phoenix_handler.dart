import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';

abstract class PhoenixHandler {
  final PhoenixMessage message;

  PhoenixHandler(this.message);

  void handle();
}
