import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/headers/header.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';

class StoreHeader extends Header {
  final VoidCallback? helpPress;
  final VoidCallback? onGoBackPress;

  final String title;
  final int numberMembers;
  final String picture;

  const StoreHeader({
    required this.title,
    required this.numberMembers,
    required this.picture,
    this.helpPress,
    this.onGoBackPress,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(96);

  @override
  Widget body(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    const double lateralPadding = 62;
    const double dimension = 50;

    return GoBack(
      onExit: onGoBackPress,
      posTop: 0,
      posLeft: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: lateralPadding,
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: dimension,
                    height: dimension,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      borderRadius: null,
                      boxShadow: [AppColor.defaultShadow],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image(
                        image: ServerImage(picture),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: maxWidth / 2.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppText.firstHeader,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "$numberMembers funcionários",
                      style: AppText.subHeader,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                iconSize: 20,
                icon: const Icon(
                  Icons.help_outline_rounded,
                  color: AppColor.helpButton,
                ),
                onPressed: helpPress,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
