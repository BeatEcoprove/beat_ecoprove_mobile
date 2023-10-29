import 'package:beat_ecoprove/core/config/data.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/bucket.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cardItem.dart';
import 'package:beat_ecoprove/core/widgets/cloth_card/cloth.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final Function(CardItemTemplate)? selectedOnChange;

  const CardList({
    Key? key,
    this.selectedOnChange,
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
            )
          : Cloth(
              key: Key(index.toString()),
              content: item.toItemModel(),
              title: item.title,
              otherProfileImage: item.otherProfileImage,
              selectionAction: selectedOnChange,
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
