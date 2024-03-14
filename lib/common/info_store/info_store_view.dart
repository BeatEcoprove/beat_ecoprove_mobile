import 'package:beat_ecoprove/common/info_store/info_store_form.dart';
import 'package:beat_ecoprove/common/info_store/info_store_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:beat_ecoprove/service_provider/stores/domain/models/store_item.dart';
import 'package:flutter/material.dart';

class InfoStoreView extends StatelessWidget {
  final StoreItem card;

  const InfoStoreView({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<InfoStoreViewModel>(),
      child: InfoStoreForm(
        card: card,
      ),
    );
  }
}
