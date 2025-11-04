import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';

class PhoenixNotificationJoinMessage extends PhoenixMessage {
  PhoenixNotificationJoinMessage(String memberId, String ref)
      : super(
          topic: 'notification:$memberId',
          event: 'phx_join',
          payload: {},
          ref: ref,
        );
}
