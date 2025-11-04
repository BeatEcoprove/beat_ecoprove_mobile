import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';

class PhoenixGroupLeaveMessage extends PhoenixMessage {
  PhoenixGroupLeaveMessage(String groupId, String ref)
      : super(
          topic: 'group:$groupId',
          event: 'phx_leave',
          payload: {},
          ref: ref,
        );
}
