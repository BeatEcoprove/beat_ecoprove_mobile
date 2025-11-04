import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';

class PhoenixGroupJoinMessage extends PhoenixMessage {
  PhoenixGroupJoinMessage(String groupId, String ref)
      : super(
          topic: 'group:$groupId',
          event: 'phx_join',
          payload: {},
          ref: ref,
        );
}
