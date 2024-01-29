import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_message.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class ChatMessageText extends ChatMessage {
  final String userName;
  final String avatarUrl;
  final String messageText;
  final DateTime createdAt;

  const ChatMessageText({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.messageText,
    required this.createdAt,
  });

  @override
  Widget body(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width - 120;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                userName,
                style: AppText.titleToScrollSection,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                messageText,
                style: AppText.smallHeader,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: PresentImage(path: ServerImage(avatarUrl)),
          ),
        ),
      ],
    );
  }
}
