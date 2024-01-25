import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_message.dart';
import 'package:flutter/material.dart';

class ChatMessageText extends ChatMessage {
  final String messageText;

  const ChatMessageText({
    super.key,
    required this.messageText,
  });

  @override
  Widget body(BuildContext context) {
    return Text(
      messageText,
      style: AppText.titleToScrollSection,
      overflow: TextOverflow.ellipsis,
      maxLines: 10,
      textAlign: TextAlign.end,
    );
  }
}
