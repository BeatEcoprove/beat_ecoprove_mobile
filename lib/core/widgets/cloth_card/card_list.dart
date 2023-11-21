import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/bucket.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cloth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardList extends StatefulWidget {
  final List<CardItem> clothesItems;
  final Function(List<int>) onSelectionChanged;
  final Function(Key) onSelectionToDelete;

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
  final List<int> selectedCardItems = [];
  final List<CardItem> selectedCardItemsToDelete = [];

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 8,
      spacing: 4,
      children: [
        for (int i = 0; i < widget.clothesItems.length; i++) ...[
          Container(
            margin: const EdgeInsets.all(4),
            child: InkWell(
              onTap: () => goRouter.push("/info/${i.toString()}",
                  extra: widget.clothesItems[i]),
              onLongPress: () {
                setState(() {
                  if (selectedCardItems.contains(i)) {
                    selectedCardItems.remove(i);
                  } else {
                    selectedCardItems.add(i);
                  }

                  widget.onSelectionChanged(selectedCardItems);
                });
              },
              child: renderCard(i),
            ),
          ),
        ],
      ],
    );
  }

  handleSelection(int i) {
    if (selectedCardItems.contains(i)) {
      return true;
    }

    return false;
  }

  renderCard(int i) {
    var cardItem = widget.clothesItems[i];

    if (cardItem.hasChildren) {
      return BucketItem(
        key: Key(i.toString()),
        items: cardItem.child,
        title: cardItem.title,
        isSelect: handleSelection(i),
        cardSelectedToDelete: widget.onSelectionToDelete,
      );
    }

    return ClothItem(
      key: Key(i.toString()),
      content: NetworkImage(cardItem.child),
      title: cardItem.title,
      otherProfileImage: cardItem.hasProfile,
      isSelect: handleSelection(i),
      cardSelectedToDelete: widget.onSelectionToDelete,
    );
  }
}
