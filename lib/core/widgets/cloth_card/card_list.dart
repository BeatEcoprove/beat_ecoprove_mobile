import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/bucket.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/card_item.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cloth.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final Function(CardItemTemplate)? selectedOnChange;
  final Function(CardItemTemplate)? removeOnAction;
  final Widget? removedCardVersion;

  const CardList({
    Key? key,
    this.selectedOnChange,
    this.removeOnAction,
    this.removedCardVersion,
  }) : super(key: key);

  List<CardItemTemplate> _convertDataToView() {
    return clothItems.map((item) {
      int index = clothItems.indexOf(item);

      return item is BucketItem
          ? Bucket(
              key: Key(index.toString()),
              items: item.toItemModel(),
              title: item.title,
              otherProfileImage: item.otherProfileImage,
              selectionAction: selectedOnChange,
              removeAction: removeOnAction,
            )
          : Cloth(
              key: Key(index.toString()),
              content: item.toItemModel(),
              title: item.title,
              otherProfileImage: item.otherProfileImage,
              selectionAction: selectedOnChange,
              removeAction: removeOnAction,
            );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 8,
      spacing: 4,
      children: [
        for (int i = 0; i < _convertDataToView().length; i++) ...[
          Container(
            margin: const EdgeInsets.all(4),
            child: _convertDataToView()[i],
          ),
        ],
      ],
    );
  }
}
