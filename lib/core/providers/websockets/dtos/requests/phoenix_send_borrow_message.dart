import 'package:beat_ecoprove/core/providers/websockets/dtos/phoenix_message.dart';

class PhoenixSendBorrowMessage extends PhoenixMessage {
  PhoenixSendBorrowMessage({
    required String groupId,
    required String content,
    required String garmentId,
    List<String> mentions = const [],
    String? replyTo,
    required String ref,
  }) : super(
          topic: 'group:$groupId',
          event: 'send_borrow_msg',
          payload: {
            'content': content,
            'garment_id': garmentId,
            'mentions': mentions,
            'reply_to': replyTo,
          },
          ref: ref,
        );
}
