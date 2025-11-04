import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';

class PhoenixSendTextMessage extends PhoenixMessage {
  PhoenixSendTextMessage({
    required String groupId,
    required String content,
    List<String> mentions = const [],
    String? replyTo,
    required String ref,
  }) : super(
          topic: 'group:$groupId',
          event: 'send_text_msg',
          payload: {
            'content': content,
            'mentions': mentions,
            'reply_to': replyTo,
          },
          ref: ref,
        );
}
