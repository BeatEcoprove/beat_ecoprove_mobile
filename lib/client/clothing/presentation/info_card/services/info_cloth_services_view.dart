import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_services_form.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/services/info_cloth_services_view_model.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class InfoClothServiceView extends StatelessWidget {
  final CardItem card;
  final IBucketInfoManager bucketInfoManager;

  const InfoClothServiceView(
      {Key? key, required this.bucketInfoManager, required this.card})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<InfoClothServiceViewModel>(),
      child: InfoClothServiceForm(
        bucketInfoManager: bucketInfoManager,
        card: card,
      ),
    );
  }
}
