import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_item.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class ChatItemRoot extends StatelessWidget {
  final bool userIsSender;
  final String avatarUrl;
  final DateTime createdAt;

  final List<ChatListItem> items;

  final VoidCallback? click;
  final VoidCallback? onPress;

  const ChatItemRoot({
    super.key,
    required this.userIsSender,
    required this.avatarUrl,
    required this.createdAt,
    required this.items,
    this.click,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    if (click != null) {
      return InkWell(
        onTap: click,
        onLongPress: onPress,
        child: body(context),
      );
    }

    return body(context);
  }

  Widget _avatar(double imageSize) {
    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: PresentImage(path: ServerImage(avatarUrl)),
      ),
    );
  }

  Widget _card(double maxWidth, double imageSize) {
    const Radius borderRadius = Radius.circular(5);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: maxWidth - imageSize - 12,
      decoration: const BoxDecoration(
        color: AppColor.widgetBackground,
        borderRadius: BorderRadius.all(borderRadius),
        boxShadow: [AppColor.defaultShadow],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items,
        ),
      ),
    );
  }

  List<Widget> _content(double maxWidth) {
    const double imageSize = 50;

    if (userIsSender) {
      return [
        _card(maxWidth, imageSize),
        _avatar(imageSize),
      ];
    } else {
      return [
        _avatar(imageSize),
        _card(maxWidth, imageSize),
      ];
    }
  }

  Widget body(BuildContext context) {
    const lateralPadding = 40;
    double maxWidth = MediaQuery.of(context).size.width - lateralPadding;
    const double margin = 6;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: margin),
      width: maxWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _content(maxWidth),
      ),
    );
  }
}
