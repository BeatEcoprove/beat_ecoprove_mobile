import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_form.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_cloth/info_cloth_view_model.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class InfoClothView extends StatelessWidget {
  final String index;
  final CardItem card;

  const InfoClothView({
    Key? key,
    required this.card,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<InfoClothViewModel>(),
      child: InfoClothForm(
        index: index,
        card: card,
      ),
    );
  }
}
