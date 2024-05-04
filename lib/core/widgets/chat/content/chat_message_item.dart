import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageItem extends ChatListItem {
  final String userName;
  final String messageText;
  final DateTime sendAt;

  const ChatMessageItem({
    super.key,
    required this.userName,
    required this.messageText,
    required this.sendAt,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: constraints.maxWidth,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(sendAt),
                      style: AppText.smallSubHeader,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 10,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
