import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/bucket.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item_template.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cloth.dart';
import 'package:beat_ecoprove/core/widgets/server_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardList extends StatefulWidget {
  final List<CardItem> clothesItems;
  final Map<String, List<String>> selectedCards;

  final Function(Map<String, List<String>>) onSelectionChanged;
  final Function(String) onSelectionToDelete;
  final Types? cardsType;

  const CardList({
    Key? key,
    required this.clothesItems,
    required this.selectedCards,
    required this.onSelectionChanged,
    required this.onSelectionToDelete,
    this.cardsType,
  }) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final List<CardItem> selectedCardItemsToDelete = [];

  renderCard(CardItem card) {
    if (card.hasChildren) {
      return BucketItem(
        id: card.id,
        items: card.child,
        title: card.title,
        isSelect: widget.selectedCards.keys.contains(card.id),
        cardSelectedToDelete: widget.onSelectionToDelete,
        cardType: widget.cardsType,
      );
    }

    return ClothItem(
      id: card.id,
      clothState: card.clothState!,
      content: ServerImage(card.child),
      title: card.title,
      subTitle: card.brand,
      otherProfileImage: card.hasProfile,
      isSelect: widget.selectedCards.keys.contains(card.id),
      cardSelectedToDelete: widget.onSelectionToDelete,
      cardType: widget.cardsType,
    );
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 8,
      spacing: 4,
      children: [
        for (var card in widget.clothesItems) ...[
          Container(
            margin: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () {
                if (!widget.selectedCards.keys.contains(card.id)) {
                  openInfoCard(card, goRouter);
                }
              },
              onLongPress: () {
                setState(() {
                  Map<String, List<String>> selectedCardItems = {};

                  selectedCardItems[card.id] = card.hasChildren
                      ? (card.child as List<CardItem>).map((e) => e.id).toList()
                      : [];
                  widget.onSelectionChanged(selectedCardItems);
                  selectedCardItems.clear();
                });
              },
              child: renderCard(card),
            ),
          ),
        ],
      ],
    );
  }

  bool isBucketItem(CardItem card) => card.hasChildren;

  void openInfoCard(CardItem card, GoRouter goRouter) {
    isBucketItem(card)
        ? goRouter.push("/info/bucket/${card.id}", extra: card)
        : goRouter.push("/info/cloth/${card.id}", extra: card);
  }
}
