import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/order_card/order_card_item.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:beat_ecoprove/core/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class OrderHeader extends OrderCardItem {
  final Widget widget;
  final String title;
  final String subTitle;
  final bool isCircular;
  final bool withoutBoxShadow;
  final CardItem cloth;
  final List<String> services;

  const OrderHeader({
    super.key,
    required this.widget,
    required this.title,
    required this.subTitle,
    required this.cloth,
    required this.services,
    this.isCircular = false,
    this.withoutBoxShadow = false,
  });

  Container _itemGrid(
    double margin,
    double height,
    double width,
    int i,
    List<CardItem> items,
  ) {
    return Container(
      margin: EdgeInsets.all(margin),
      child: Container(
        height: height,
        width: width,
        color: AppColor.widgetBackground,
        child: i < items.length
            ? PresentImage(
                path: ServerImage(items[i].child),
              )
            : Container(
                height: height,
                width: width,
                color: AppColor.widgetBackgroundWithNothing,
              ),
      ),
    );
  }

  Widget _bucket(BoxConstraints constraints) {
    return Row(
      children: [
        SizedBox(
          height: 112,
          width: constraints.maxWidth * (1 / 3),
          child: Column(
            children: [
              SizedBox(
                height: 86,
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runSpacing: 1,
                    spacing: 1,
                    children: [
                      for (int i = 0; i < 4; i++) ...[
                        _itemGrid(6, 50, 40, i, cloth.child),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        SizedBox(
          width: constraints.maxWidth * (2 / 3) - 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cloth.title,
                style: AppText.titleToScrollSection,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "Quantidade: ${(cloth.child as List<dynamic>).length}",
                style: AppText.subHeader,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cloth(BoxConstraints constraints) {
    return Row(
      children: [
        SizedBox(
          width: constraints.maxWidth * (1 / 3),
          child: Column(
            children: [
              SizedBox(
                height: 86,
                child: PresentImage(
                  path: ServerImage(cloth.child),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        SizedBox(
          width: constraints.maxWidth * (2 / 3) - 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cloth.title,
                style: AppText.titleToScrollSection,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                cloth.brand!,
                style: AppText.subHeader,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Text(
                    "Color:",
                    style: AppText.strongStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: cloth.color,
                      shape: BoxShape.circle,
                      boxShadow: const [AppColor.defaultShadow],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  const Text(
                    "Tamanho:",
                    style: AppText.strongStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    cloth.size!,
                    style: AppText.smallHeader,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Eco-Score",
                    style: AppText.smallSubHeader,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Points.ecoScore(points: cloth.ecoScore!),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _service(String service, double dimension) {
    double iconDimension = dimension * (2 / 3);
    switch (service) {
      case "recycle":
      case "Reciclar":
        return IconButtonRectangular(
          dimension: dimension,
          colorBackground: AppColor.darkGreen,
          isCircular: true,
          object: SvgImage(
            path: 'assets/services/recycle.svg',
            width: iconDimension,
            height: iconDimension,
          ),
        );
      case "iron":
      case "Engomar":
        return IconButtonRectangular(
          dimension: dimension,
          colorBackground: AppColor.orange,
          isCircular: true,
          object: SvgImage(
            path: 'assets/services/iron.svg',
            width: iconDimension,
            height: iconDimension,
          ),
        );

      case "dry":
      case "Secar":
        return IconButtonRectangular(
          dimension: dimension,
          colorBackground: AppColor.yellow,
          isCircular: true,
          object: SvgImage(
            path: 'assets/services/dry.svg',
            width: iconDimension,
            height: iconDimension,
          ),
        );

      case "wash":
      case "Lavar":
        return IconButtonRectangular(
          dimension: dimension,
          colorBackground: AppColor.lightBlue,
          isCircular: true,
          object: SvgImage(
            path: 'assets/services/wash.svg',
            width: iconDimension + 10,
            height: iconDimension + 10,
          ),
        );

      case "repair":
      case "Reparar":
        return IconButtonRectangular(
          dimension: dimension,
          colorBackground: AppColor.darkBlue,
          isCircular: true,
          object: SvgImage(
            path: 'assets/services/repair.svg',
            width: iconDimension,
            height: iconDimension,
          ),
        );
    }
    return Container();
  }

  List<Widget> _services() {
    List<Widget> serviceWidgets = [];
    if (services.isNotEmpty) {
      serviceWidgets.add(
        Align(
          alignment: Alignment.centerRight,
          child: _service(services[0], 50),
        ),
      );
    }
    if (services.length > 1) {
      serviceWidgets.add(
        Positioned(
          bottom: 0,
          left: 12,
          child: _service(services[1], 35),
        ),
      );
    }
    if (services.length > 2) {
      serviceWidgets.add(
        Positioned(
          top: 0,
          right: 50,
          child: _service(services[2], 25),
        ),
      );
    }
    if (services.length > 3) {
      serviceWidgets.add(
        Positioned(
          left: 0,
          top: 17,
          child: _service(services[3], 20),
        ),
      );
    }
    if (services.length > 4) {
      serviceWidgets.add(
        Positioned(
          top: 0,
          left: 4,
          child: _service(services[4], 15),
        ),
      );
    }
    return serviceWidgets;
  }

  @override
  Widget build(BuildContext context) {
    double extraPadding = 8;
    double imageSize = 60;
    double servicesSize = 96;

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
                  SizedBox(
                    height: 68,
                    child: Row(
                      children: [
                        IconButtonRectangular(
                          isCircular: isCircular,
                          dimension: imageSize,
                          object: widget,
                          withoutBoxShadow: withoutBoxShadow,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: constraints.maxWidth -
                                  imageSize -
                                  servicesSize -
                                  (extraPadding * 2),
                              child: Text(
                                title,
                                style: AppText.titleToScrollSection,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth -
                                  imageSize -
                                  servicesSize -
                                  (extraPadding * 2),
                              child: Text(
                                subTitle,
                                style: AppText.subHeader,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: servicesSize,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: servicesSize,
                                child: Container(),
                              ),
                              ..._services(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: Line(
                      width: constraints.maxWidth - 40,
                      color: AppColor.separatedLine,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  cloth.hasChildren
                      ? _bucket(constraints)
                      : _cloth(constraints),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
