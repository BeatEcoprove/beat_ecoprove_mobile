import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

abstract class ChatMessage extends StatelessWidget {
  Widget body(BuildContext context);

  const ChatMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const lateralPadding = 40;
    double maxWidth = MediaQuery.of(context).size.width - lateralPadding;
    const Radius borderRadius = Radius.circular(5);

    return Column(
      children: [
        const SizedBox(
          height: 2,
        ),
        Container(
          width: maxWidth,
          decoration: const BoxDecoration(
            color: AppColor.widgetBackground,
            borderRadius: BorderRadius.all(borderRadius),
            boxShadow: [AppColor.defaultShadow],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: body(context),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }
}
