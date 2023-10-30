import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cardItem.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:flutter/material.dart';

class DialogCard extends StatelessWidget {
  final String text;
  final ExtendedItem card;
  final VoidCallback? firstAction;
  final VoidCallback? secondAction;

  const DialogCard({
    super.key,
    required this.text,
    required this.card,
    this.firstAction,
    this.secondAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 54,
          horizontal: 36,
        ),
        decoration: const BoxDecoration(
          color: AppColor.widgetBackground,
          borderRadius: AppColor.borderRadius,
          boxShadow: [AppColor.defaultShadow],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            card,
            const SizedBox(
              height: 18,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 3,
              style: AppText.strongStyle,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 14,
            ),
            FormattedButton(
              content: "Remover",
              buttonColor: AppColor.buttonBackground,
              textColor: AppColor.widgetBackground,
              height: 46,
              onPress: firstAction,
            ),
            const SizedBox(
              height: 6,
            ),
            FormattedButton(
              content: "Cancelar",
              buttonColor: AppColor.widgetBackground,
              textColor: AppColor.black,
              height: 46,
              onPress: secondAction,
            ),
          ],
        ),
      ),
    );
  }
}
