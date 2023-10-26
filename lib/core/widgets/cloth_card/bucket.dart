import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cloth_card.dart';
import 'package:flutter/material.dart';

class Bucket extends StatelessWidget {
  final String name;
  final List<ClothItem> items;

  const Bucket({
    super.key,
    required this.name,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > AppColor.maxWidthToImage) {
          return ClothCard(
            name: name,
            content: Center(
              child: Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 1,
                spacing: 1,
                children: [
                  for (int i = 0; useFourItemsImagesToBucket(i); i++) ...[
                    Container(
                      margin: const EdgeInsets.all(6),
                      child: Container(
                        height: 50,
                        width: 40,
                        color: AppColor.widgetBackground,
                        child: items[i].content,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        } else {
          return ClothCard(
            name: name,
            content: Center(
              child: Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 1,
                spacing: 1,
                children: [
                  for (int i = 0; useFourItemsImagesToBucket(i); i++) ...[
                    Container(
                      margin: const EdgeInsets.all(2),
                      child: Container(
                        height: 20,
                        width: 20,
                        color: AppColor.widgetBackground,
                        child: items[i].content,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
      },
    );
  }

  bool useFourItemsImagesToBucket(int i) => i < items.length && i < 4;
}
