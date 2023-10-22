import 'package:beat_ecoprove/core/config/global.dart';
import 'package:flutter/material.dart';

class AdvertisementCardTextContext extends StatelessWidget {
  final String title;
  final String subTitle;

  const AdvertisementCardTextContext(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                maxLines: 4,
                style: AppText.smallHeader,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subTitle,
                maxLines: 5,
                style: AppText.smallSubHeader,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    );
  }
}
