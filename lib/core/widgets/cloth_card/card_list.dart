import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/bucket.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cloth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardList extends StatefulWidget {
  final List<CardItem> clothesItems;
  final Function(List<String>) onSelectionChanged;
  final Function(String) onSelectionToDelete;

  const CardList({
    Key? key,
    required this.clothesItems,
    required this.onSelectionChanged,
    required this.onSelectionToDelete,
  }) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final List<String> selectedCardItems = [];
  final List<CardItem> selectedCardItemsToDelete = [];

  renderCard(CardItem card) {
    if (card.hasChildren) {
      return BucketItem(
        id: card.id,
        items: card.child,
        title: card.title,
        isSelect: selectedCardItems.contains(card.id),
        cardSelectedToDelete: widget.onSelectionToDelete,
      );
    }

    return ClothItem(
      id: card.id,
      clothState: card.clothState!,
      content: NetworkImage(card.child),
      title: card.title,
      otherProfileImage: card.hasProfile,
      isSelect: selectedCardItems.contains(card.id),
      cardSelectedToDelete: widget.onSelectionToDelete,
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
                openInfoCard(card, goRouter);
              },
              onLongPress: () {
                setState(() {
                  if (selectedCardItems.contains(card.id)) {
                    selectedCardItems.remove(card.id);
                  } else {
                    selectedCardItems.add(card.id);
                  }

                  widget.onSelectionChanged(selectedCardItems);
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
