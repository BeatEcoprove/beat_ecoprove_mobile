import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/icon_button_rectangular.dart';
import 'package:beat_ecoprove/core/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class AdvertisementCardProviderContext extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconButtonRectangular icon;
  final List<IconButtonRetangularType> services;
  final double rating;

  const AdvertisementCardProviderContext({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.services,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppText.smallHeader,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subTitle,
                        style: AppText.smallSubHeader,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                icon,
              ],
            ),
          ],
        ),
        Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Serviços Prestados",
                  style: AppText.subHeader,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(color: Colors.transparent),
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (int i = 0; i < services.length; i++) ...[
                      IconButtonRectangular(
                        colorBackground: services[i].colorBackground,
                        object: services[i].object,
                      ),
                    ],
                  ],
                )
              ],
            ),
          ],
        ),
        Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Rating Global",
                  style: AppText.subHeader,
                ),
                RatingBarWidget(canRating: true, rating: rating),
              ],
            )
          ],
        )
      ],
    );
  }
}
