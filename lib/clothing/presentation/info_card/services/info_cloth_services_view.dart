import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_form.dart';
import 'package:beat_ecoprove/clothing/presentation/info_card/services/info_cloth_services_view_model.dart';
import 'package:beat_ecoprove/core/view_model_provider.dart';
import 'package:beat_ecoprove/dependency_injection.dart';
import 'package:flutter/material.dart';

class InfoClothServiceView extends StatelessWidget {
  const InfoClothServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewModel: DependencyInjection.locator<InfoClothServiceViewModel>(),
      child: const InfoClothServiceForm(),
    );
  }
}
