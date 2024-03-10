import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_form.dart';
import 'package:beat_ecoprove/client/clothing/presentation/info_card/info_bucket/info_bucket_view_model.dart';
import 'package:beat_ecoprove/core/domain/models/card_item.dart';
import 'package:beat_ecoprove/core/providers/closet/bucket_info_manager.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class InfoBucketView extends StatelessWidget {
  final String index;
  final CardItem card;
  final IBucketInfoManager bucketInfoManager;

  const InfoBucketView({
    Key? key,
    required this.bucketInfoManager,
    required this.card,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<InfoBucketViewModel>(),
      child: InfoBucketForm(
        bucketInfoManager: bucketInfoManager,
        index: index,
        card: card,
      ),
    );
  }
}
