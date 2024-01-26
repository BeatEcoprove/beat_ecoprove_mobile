import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/formatted_button/formated_button.dart';
import 'package:flutter/material.dart';

class Modal {
  late OverlayEntry _overlayEntry;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final VoidCallback action;
  final String buttonText;
  final String titleModal;
  final bool hasCancelButton;

  Modal({
    this.right = 16,
    this.top = 16,
    this.bottom = 16,
    this.left = 16,
    required this.action,
    required this.buttonText,
    required this.titleModal,
    this.hasCancelButton = true,
  });

  create(BuildContext context, Widget content) {
    const Radius borderRadius = Radius.circular(5);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0,
              child: Container(
                color: AppColor.widgetBackgroundBlurry,
                child: GestureDetector(
                  onTap: () {
                    remove();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: left,
            right: right,
            bottom: bottom,
            top: top,
            child: Material(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColor.widgetBackground,
                  borderRadius: BorderRadius.all(borderRadius),
                  boxShadow: [AppColor.defaultShadow],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 36,
                              ),
                              Text(
                                titleModal,
                                style: AppText.titleToScrollSection,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 62,
                              ),
                              content,
                              const SizedBox(
                                height: 62,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              FormattedButton(
                                  content: buttonText,
                                  buttonColor: AppColor.buttonBackground,
                                  textColor: AppColor.widgetBackground,
                                  height: 46,
                                  onPress: () => {
                                        action(),
                                        remove(),
                                      }),
                              const SizedBox(
                                height: 6,
                              ),
                              if (hasCancelButton)
                                FormattedButton(
                                  content: "Cancelar",
                                  buttonColor: AppColor.widgetBackground,
                                  textColor: AppColor.black,
                                  height: 46,
                                  onPress: () => remove(),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry);
  }

  remove() {
    _overlayEntry.remove();
  }
}
