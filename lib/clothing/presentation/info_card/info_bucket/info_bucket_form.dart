import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/info_bucket/info_bucket_view_model.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/view_model.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item_template.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_list.dart';
import 'package:flutter/material.dart';

class InfoBucketForm extends StatefulWidget {
  final String index;
  final CardItem card;

  InfoBucketForm({
    super.key,
    required this.card,
    required this.index,
  });

  final GlobalKey _buttonKey = GlobalKey();

  @override
  State<InfoBucketForm> createState() => _InfoBucketFormState();
}

class _InfoBucketFormState extends State<InfoBucketForm> {
  late List<OptionItem> options;
  final List<String> selectedCardItems = [];

  Widget renderCards(InfoBucketViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardList(
          selectedCards: viewModel.selectedCards,
          clothesItems: widget.card.child,
          onSelectionChanged: (cards) =>
              {viewModel.changeCardsSelection(cards)},
          onSelectionToDelete: (cards) => (cards),
          selectedIcon: Icons.lock_rounded,
          cardsType: Types.compact,
          action: "removeFromBucket",
          actionToOptionRemoveFromBucket: (idCloth) async {
            widget.card.id == "outfit"
                ? await viewModel.unMarkClothsFromBucket(idCloth)
                : await viewModel.removeClothFromBucket(
                    idCloth, widget.card.id);
          },
        ),
      ],
    );
  }

  //TODO: CREATE GLOBAL FUNCTION
  void _showOptionsMenu(BuildContext context, InfoBucketViewModel viewModel) {
    final RenderBox buttonRenderBox =
        widget._buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);

    options = [
      if (widget.card.id == "outfit") ...{
        OptionItem(
          name: 'Desmarcar Uso',
          action: () => {
            {
              viewModel.unMarkClothsFromBucket(
                (widget.card.child as List<CardItem>).map((e) => e.id).toList(),
              ),
            }
          },
        ),
      } else ...{
        OptionItem(
          name: 'Remover Tudo',
          action: () => {
            viewModel.removeClothFromBucket(
                (widget.card.child as List<CardItem>).map((e) => e.id).toList(),
                widget.card.id),
          },
        ),
      }
    ];

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonPosition.dx,
        buttonPosition.dy,
        buttonPosition.dx + buttonRenderBox.size.width,
        buttonPosition.dy + buttonRenderBox.size.height,
      ),
      items: options.map((option) {
        return PopupMenuItem(
          onTap: option.action,
          child: Text(option.name),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ViewModel.of<InfoBucketViewModel>(context);
    double maxWidth = MediaQuery.of(context).size.width;
    const Radius borderRadius = Radius.circular(5);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    key: widget._buttonKey,
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: AppColor.widgetSecondary,
                    ),
                    onPressed: () {
                      _showOptionsMenu(context, viewModel);
                    }),
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
                      child: renderCards(viewModel),
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
