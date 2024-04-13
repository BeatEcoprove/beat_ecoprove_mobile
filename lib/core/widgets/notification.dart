import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class NotificationBanner extends StatefulWidget {
  static const double sizeIcons = 36;
  final VoidCallback? onClose;
  final Duration activeDuration;
  final Duration animationDelay;

  final String message;
  final Icon icon;
  final Color backgroundColor;
  final Color primaryColor;

  const NotificationBanner({
    super.key,
    this.onClose,
    required this.activeDuration,
    required this.animationDelay,
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.primaryColor,
  });

  const NotificationBanner.error({
    super.key,
    required this.message,
    this.icon = const Icon(
      Icons.close_rounded,
      color: Colors.white,
      size: sizeIcons,
    ),
    this.backgroundColor = AppColor.error,
    this.primaryColor = AppColor.primaryError,
    this.onClose,
    required this.activeDuration,
    required this.animationDelay,
  });

  const NotificationBanner.warning({
    super.key,
    required this.message,
    this.icon = const Icon(
      Icons.warning_amber_rounded,
      color: Colors.white,
      size: sizeIcons,
    ),
    this.backgroundColor = AppColor.warning,
    this.primaryColor = AppColor.primaryWarning,
    this.onClose,
    required this.activeDuration,
    required this.animationDelay,
  });

  const NotificationBanner.info({
    super.key,
    required this.message,
    this.icon = const Icon(
      Icons.info_outline_rounded,
      color: Colors.white,
      size: sizeIcons,
    ),
    this.backgroundColor = AppColor.info,
    this.primaryColor = AppColor.primaryInfo,
    this.onClose,
    required this.activeDuration,
    required this.animationDelay,
  });

  const NotificationBanner.success({
    super.key,
    required this.message,
    this.icon = const Icon(
      Icons.check_circle_outline_rounded,
      color: Colors.white,
      size: sizeIcons,
    ),
    this.backgroundColor = AppColor.primaryColor,
    this.primaryColor = AppColor.darkGreen,
    this.onClose,
    required this.activeDuration,
    required this.animationDelay,
  });

  @override
  State<NotificationBanner> createState() => _NotificationBannerState();
}

class _NotificationBannerState extends State<NotificationBanner>
    with SingleTickerProviderStateMixin {
  static const Radius borderRadius = Radius.circular(10);

  static const Curve curve = Curves.decelerate;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDelay,
    );

    _playAnimation();
  }

  void _playAnimation() async {
    await _controller.forward();
    await Future<void>.delayed(widget.activeDuration);
    await _controller.reverse();

    widget.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {
    const double height = 88;

    return AnimatedBuilder(
      builder: (context, child) {
        final double animationValue = curve.transform(_controller.value);
        return FractionalTranslation(
          translation: Offset((1 - animationValue), 0),
          child: child,
        );
      },
      animation: _controller,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: const BorderRadius.all(borderRadius),
                boxShadow: const [AppColor.defaultShadow],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [AppColor.defaultShadow],
                    ),
                    child: SvgImage(
                      color: widget.primaryColor,
                      path: 'assets/background5/background1.svg',
                      height: height,
                      width: height,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: InkWell(
                onTap: () => widget.onClose,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70,
                      height: height,
                      decoration: BoxDecoration(
                        color: widget.primaryColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                          bottomLeft: borderRadius,
                          topLeft: borderRadius,
                        ),
                        boxShadow: const [AppColor.defaultShadow],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.icon,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                margin: const EdgeInsets.only(
                  top: height / 3,
                  bottom: height / 2,
                  left: 80,
                  right: 10,
                ),
                child: Text(
                  widget.message,
                  style: AppText.textButton,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
