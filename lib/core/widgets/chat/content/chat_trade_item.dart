import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/chat/chat_item.dart';
import 'package:beat_ecoprove/core/widgets/line.dart';
import 'package:beat_ecoprove/core/widgets/points.dart';
import 'package:beat_ecoprove/core/widgets/present_image.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class ChatTradeItem extends ChatListItem {
  final String clothImage;
  final String clothName;
  final String clothBrand;
  final String clothColor;
  final String clothSize;
  final int clothEcoScore;
  final bool isBlocked;

  const ChatTradeItem({
    super.key,
    required super.userName,
    required super.messageText,
    required super.sendAt,
    required this.clothImage,
    required this.clothName,
    required this.clothBrand,
    required this.clothColor,
    required this.clothSize,
    required this.clothEcoScore,
    required this.isBlocked,
  });

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
                  path: ServerImage(clothImage),
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
                clothName,
                style: AppText.titleToScrollSection,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                clothBrand,
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
                      color: Color(
                        int.parse(
                          clothColor,
                          radix: 16,
                        ),
                      ),
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
                    clothSize,
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
                  Points.ecoScore(points: clothEcoScore),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double extraPadding = 8;
    double sizeSelectedIcon = 50;
    IconData selectedIcon = Icons.lock_rounded;

    return Stack(
      children: [
        LayoutBuilder(
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
                      Padding(
                        padding: EdgeInsets.all(extraPadding),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      constraints.maxWidth - (extraPadding * 2),
                                  child: Text(
                                    userName,
                                    style: AppText.titleToScrollSection,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      constraints.maxWidth - (extraPadding * 2),
                                  child: Text(
                                    messageText,
                                    style: AppText.subHeader,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
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
                      _cloth(constraints),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        if (isBlocked)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(162, 255, 255, 255),
                borderRadius: AppColor.borderRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Já não está disponível!",
                    style: AppText.titleToScrollSection,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Icon(
                    size: sizeSelectedIcon,
                    selectedIcon,
                    color: AppColor.buttonBackground,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
