import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/widgets/headers/header.dart';
import 'package:flutter/material.dart';

class GroupHeader extends Header {
  final VoidCallback? helpPress;
  final VoidCallback? onGoBackPress;

  final String title;
  final String state;
  final String numberMembers;

  const GroupHeader({
    required this.title,
    required this.state,
    required this.numberMembers,
    this.helpPress,
    this.onGoBackPress,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(108);

  @override
  Widget body(BuildContext context) {
    const border = Radius.circular(25);
    const lateralPadding = 40;
    double maxWidth = (MediaQuery.of(context).size.width - lateralPadding) / 3;
    double maxWidthDisplay = (MediaQuery.of(context).size.width);

    return GoBack(
      onExit: onGoBackPress,
      posTop: 0,
      posLeft: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: maxWidthDisplay - 150,
                    child: Text(
                      title,
                      style: AppText.firstHeader,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, right: 16),
                      child: Text(
                        "$numberMembers membros",
                        style: AppText.subHeader,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: 150,
                      height: 38,
                      decoration: const BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: border, topLeft: border),
                          boxShadow: [AppColor.defaultShadow]),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          state,
                          style: AppText.textButton,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: maxWidth,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 20,
                    icon: const Icon(
                      Icons.help_outline_rounded,
                      color: AppColor.helpButton,
                    ),
                    onPressed: helpPress,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
