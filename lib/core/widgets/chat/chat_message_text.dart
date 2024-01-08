import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_message.dart';
import 'package:flutter/material.dart';

class ChatMessageText extends ChatMessage {
  const ChatMessageText({
    super.key,
  });

  @override
  Widget body(BuildContext context) {
    return const Text(
      "Hello World!",
      style: AppText.titleToScrollSection,
      overflow: TextOverflow.ellipsis,
      maxLines: 10,
      textAlign: TextAlign.end,
    );
  }
}
