import 'package:beat_ecoprove/auth/widgets/go_back.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_params.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_view_model.dart';
import 'package:beat_ecoprove/client/clothing/routes.dart';
import 'package:beat_ecoprove/core/argument_view.dart';
import 'package:beat_ecoprove/core/config/global.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/domain/models/optionItem.dart';
import 'package:beat_ecoprove/core/helpers/navigation/navigation_manager.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/widgets/application_background.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item_template.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoBucketView
    extends ArgumentView<InfoBucketViewModel, InfoBucketParams> {
  final INavigationManager _navigationManager;
  final IBucketInfoManager bucketInfoManager;
  final GlobalKey _buttonKey = GlobalKey();
  final Radius borderRadius = const Radius.circular(5);
  late List<OptionItem> options;

  InfoBucketView(
    this.bucketInfoManager,
    this._navigationManager, {
    super.key,
    required super.viewModel,
    required super.args,
  });

  Widget renderCards(InfoBucketViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardList(
          selectedCards: viewModel.selectedCards,
          clothesItems: args.card.child,
          onSelectionChanged: (cards) =>
              {viewModel.changeCardsSelection(cards)},
          onSelectionToDelete: (cards) => (cards),
          selectedIcon: Icons.lock_rounded,
          cardsType: Types.compact,
          action: "removeFromBucket",
          actionToOptionRemoveFromBucket: (idCloth) async {
            args.card.id == "outfit"
                ? await viewModel.unMarkClothsFromBucket(args.card, idCloth)
                : await viewModel.removeClothFromBucket(
                    args.card, idCloth, args.card.id);
          },
          onElementSelected: (card) async => await viewModel.openInfoCard(card),
        ),
      ],
    );
  }

  //TODO: CREATE GLOBAL FUNCTION
  void _showOptionsMenu(BuildContext context, InfoBucketViewModel viewModel) {
    final RenderBox buttonRenderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);

    options = [
      if (args.card.id == "outfit") ...{
        OptionItem(
          name: 'Desmarcar Uso',
          action: () => {
            {
              viewModel.unMarkClothsFromBucket(
                args.card,
                (args.card.child as List<CardItem>).map((e) => e.id).toList(),
              ),
            }
          },
        ),
      } else ...{
        OptionItem(
          name: 'Mudar Nome',
          action: () => {
            _navigationManager.push(
              ClothingRoutes.setChangeBucketName(args.card.id),
              extras: args.card,
            )
          },
        ),
        OptionItem(
          name: 'Remover Tudo',
          action: () async => {
            await viewModel.removeClothFromBucket(
                args.card,
                (args.card.child as List<CardItem>).map((e) => e.id).toList(),
                args.card.id),
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
  Widget build(BuildContext context, InfoBucketViewModel viewModel) {
    final double maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GoBack(
        posTop: 18,
        posLeft: 18,
        onExit: () => bucketInfoManager.removeClothes(),
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
                  decoration: BoxDecoration(
                      color: AppColor.widgetBackground,
                      boxShadow: const [AppColor.defaultShadow],
                      borderRadius: BorderRadius.all(borderRadius)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      args.card.title,
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
                    key: _buttonKey,
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
