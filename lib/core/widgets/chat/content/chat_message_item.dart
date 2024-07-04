import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/services/datetime_service.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_item.dart';
import 'package:flutter/material.dart';

class ChatMessageItem extends ChatListItem {
  const ChatMessageItem({
    super.key,
    required super.userName,
    required super.messageText,
    required super.sendAt,
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
                  if (sendAt != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        DatetimeService.formatDate(sendAt!),
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
