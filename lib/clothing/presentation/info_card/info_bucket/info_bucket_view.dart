import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item_template.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_list.dart';
import 'package:flutter/material.dart';

class InfoBucketView extends StatefulWidget {
  final String index;
  final CardItem card;

  const InfoBucketView({
    super.key,
    required this.card,
    required this.index,
  });

  @override
  State<InfoBucketView> createState() => _InfoBucketViewState();
}

class _InfoBucketViewState extends State<InfoBucketView> {
  final List<String> selectedCardItems = [];

  Widget renderCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardList(
          //TODO: Ardeu
          selectedCards: {},
          clothesItems: widget.card.child,
          //Não fazem nada
          onSelectionChanged: (cards) => (cards),
          onSelectionToDelete: (cards) => (cards),
          cardsType: Types.compact,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    const Radius borderRadius = Radius.circular(5);

    return Scaffold(
      body: GoBack(
        posTop: 18,
        posLeft: 18,
        child: AppBackground(
          content: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Positioned(
                top: 24,
                left: 82,
                right: 82,
                height: 36,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColor.widgetBackground,
                      boxShadow: [AppColor.defaultShadow],
                      borderRadius: BorderRadius.all(borderRadius)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.card.title,
                      style: AppText.headerBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                right: 28,
                child: IconButton(
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: AppColor.widgetSecondary,
                  ),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 82,
                bottom: 0,
                child: Container(
                  width: maxWidth,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: renderCards(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          type: AppBackgrounds.infoBucket,
        ),
      ),
    );
  }
}
