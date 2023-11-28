import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class OverlayWidget {
  late OverlayEntry _overlayEntry;
  final double left;
  final double right;
  final double top;
  final double bottom;
  final Widget button;
  final double buttonRight;
  final double buttonTop;

  OverlayWidget({
    this.right = 16,
    this.top = 16,
    this.bottom = 16,
    this.left = 16,
    required this.button,
    this.buttonRight = 0,
    this.buttonTop = 0,
  });

  create(BuildContext context, Widget content) {
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
            child: content,
          ),
          Positioned(
            right: right + buttonRight,
            top: top + buttonTop,
            child: GestureDetector(
              onTap: () {
                remove();
              },
              child: button,
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
